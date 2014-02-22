# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    text_overlay "MyText"
    photo_link "MyText"
    good 1
    evil 1
  end
end
