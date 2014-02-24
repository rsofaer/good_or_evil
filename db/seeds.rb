for i in 1..5
  User.create(email:"test#{i}@test.com", password:"password", password_confirmation:"password")
end

u1 = User.find(1)
u2 = User.find(2)
u3 = User.find(3)
u4 = User.find(4)
u5 = User.find(5)

for i in 1..5
  u1.posts.create(text_overlay:"Post#{i}", photo_link:"http://ilikeswhatilikes.files.wordpress.com/2013/09/adventure-time-2.jpg")
  u2.posts.create(text_overlay:"Post#{i}", photo_link:"http://static6.businessinsider.com/image/52161af5ecad04d102000058/ad-of-the-day-hooters-waitress-gets-quizzed-on-her-football-knowledge.jpg")
  u3.posts.create(text_overlay:"Post#{i}", photo_link:"http://rack.2.mshcdn.com/media/ZgkyMDE0LzAyLzE2LzdhL1Bob3Rvb2Z0aGVELmY1NWZiLmpwZwpwCXRodW1iCTk1MHg1MzQjCmUJanBn/e7c4d67d/aa2/Photo-of-the-Day.jpg")
  u4.posts.create(text_overlay:"Post#{i}", photo_link:"https://lh6.googleusercontent.com/-T8JYHT_zcEE/AAAAAAAAAAI/AAAAAAAACHc/8NZRazvAlKg/photo.jpg")
  u5.posts.create(text_overlay:"Post#{i}", photo_link:"http://graphics8.nytimes.com/images/2012/08/09/world/asia/9Aug-POD-IndiaInk/9Aug-POD-IndiaInk-blog480.jpg")
end

User.all.each do |user|
  user.posts.each do |post|
    post.comments.create(body:"test comment")
    post.likes.create(good?:true)
    post.likes.create(good?:false) 
    post.comments.each do |comment|
      comment.likes.create(good?:true)
      comment.likes.create(good?:false)
    end
  end
end
