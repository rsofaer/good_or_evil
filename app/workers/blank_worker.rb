class BlankWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(post_id)
    post = Post.find(post_id)

    rmagick_bg_name = SecureRandom.hex

    dir = File.dirname("#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg")
    FileUtils.mkdir_p(dir) unless File.directory?(dir)

    str = "caption:#{post.text_overlay}"
    img = Magick::Image.read(str) {
      self.size = "360x480"
      self.gravity = Magick::CenterGravity
      self.background_color = "black"
      self.stroke = '#000000'
      self.fill = '#ffffff'
    }
    img[0].write("#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg")

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
