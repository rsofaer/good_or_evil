class BlankWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(post_id)
    post = Post.find(post_id)

    img = Magick::Image.new(360,480) {
      self.background_color = "gray"
    }
    rmagick_bg_name = SecureRandom.hex

    dir = File.dirname("#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg")
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    img.write("#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg")

    txt = Magick::Draw.new

    txt.annotate(img, 0, 0, 0, 60, "#{post.text_overlay}") {
      self.gravity = Magick::CenterGravity
      self.pointsize = 20
      self.stroke = '#000000'
      self.fill = '#ffffff'
      self.font_weight = Magick::BoldWeight
    }
    img.write("#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg")
    img.format = 'jpeg'

    s3 = AWS::S3.new
    bucket_name = "goodevil"
    file_name = "#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg"
    key = File.basename("#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg")
    bucket = s3.buckets[bucket_name]
    s3.buckets["goodevil"].objects[key].write(:file => file_name)
    post.update_attributes(photo_link: "https://s3.amazonaws.com/goodevil/"+"#{rmagick_bg_name}.jpg")
    File.delay_for(2.minutes).delete("#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg")
  end
end
