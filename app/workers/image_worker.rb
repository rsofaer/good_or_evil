class ImageWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(post_id)
    post = Post.find(post_id)

    image_caption = "caption:#{post.text_overlay}"
    image_for_caption = Magick::Image.read(image_caption) {
      self.size = "360x480"
      self.gravity = Magick::CenterGravity
      self.stroke = '#000000'
      self.fill = '#ffffff'
      self.pointsize = 24
      self.font = "Arial"

      self.background_color= "Transparent"
    }

    image_for_caption[0].write("#{Rails.root}/public/uploads/post/photo/#{post.id}/caption.png")

    source = Magick::Image.read("#{Rails.root}/public#{post.photo.url}").first
    overlay = Magick::Image.read("#{Rails.root}/public/uploads/post/photo/#{post.id}/caption.png").first
    source.composite!(overlay, 50, 0, Magick::OverCompositeOp)
    source.write("#{Rails.root}/public#{post.photo.url}")

    AWS.config({
                 :access_key_id     => ENV['S3_KEY'],
                 :secret_access_key => ENV['S3_SECRET']
    })

    #The s3 variable is creating a new connection to the S3 cloud storage.
    s3 = AWS::S3.new
    bucket_name = "goodevil" #This is the repository for images on the amazon account.
    "public#{post.photo.url}"
    File.basename("public#{post.photo.url}")
    bucket = s3.buckets[bucket_name]
    s3.buckets["goodevil"].objects[File.basename("public#{post.photo.url}")].write(:file => "public#{post.photo.url}")
    post.update_attributes(photo_link: "https://s3.amazonaws.com/goodevil/"+"#{post.photo.filename}")
    File.delay_for(2.minutes).delete("#{Rails.root}/public#{post.photo.url}")
  end
end
