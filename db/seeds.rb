for i in 1..5
  User.create(email:"test#{i}@test.com", password:"password", password_confirmation:"password")
end

u1 = User.find(1)
u2 = User.find(2)
u3 = User.find(3)
u4 = User.find(4)
u5 = User.find(5)

for i in 1..5
  u1.posts.create(text_overlay:"Post#{i}")
  u2.posts.create(text_overlay:"Post#{i}")
  u3.posts.create(text_overlay:"Post#{i}")
  u4.posts.create(text_overlay:"Post#{i}")
  u5.posts.create(text_overlay:"Post#{i}")
end

User.all.each do |user|
  user.posts.each do |post|
    post.comments.create(body:"test comment#{i}")
    post.likes.create(good?:true)
    post.likes.create(good?:false) 
    post.comments.each do |comment|
      comment.likes.create(good?:true)
      comment.likes.create(good?:false)
    end
  end
end
