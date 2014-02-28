for i in 1..5
  User.create(email:"test#{i}@test.com", password:"password", password_confirmation:"password")
end

u1 = User.find(1)
u2 = User.find(2)
u3 = User.find(3)
u4 = User.find(4)
u5 = User.find(5)

file = (File.open(File.join(Rails.root, '/public/images/chimp.jpg')))
post = Post.create!(text_overlay: "test", photo: file, photo_link: "https://s3.amazonaws.com/goodevil/", user_id: u1.id)

s3 = AWS::S3.new
bucket_name = "goodevil"
path = file.path
key = post.photo.file.original_filename
s3.buckets["goodevil"].objects[key].write(:file => path)
post.update_attributes(photo_link: "https://s3.amazonaws.com/goodevil/" + post.photo.file.original_filename)


file = (File.open(File.join(Rails.root, '/public/images/chimp.jpg')))
post = Post.create!(text_overlay: "test", photo: file, photo_link: "https://s3.amazonaws.com/goodevil/", user_id: u1.id)

s3 = AWS::S3.new
bucket_name = "goodevil"
path = file.path
key = post.photo.file.original_filename
s3.buckets["goodevil"].objects[key].write(:file => path)
post.update_attributes(photo_link: "https://s3.amazonaws.com/goodevil/" + post.photo.file.original_filename)






User.all.each do |user|
  user.posts.each do |post|
    post.comments.create(body:"test comment")
    post.likes.create(good:true)
    post.likes.create(good:false)
    post.comments.each do |comment|
      comment.likes.create(good:true)
      comment.likes.create(good:false)
    end
  end
