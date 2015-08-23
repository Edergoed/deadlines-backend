FactoryGirl.define do
  factory :deadline do
    title { FFaker::Product.product_name }
    subject { FFaker::Product.product_name }
    deadline { rand(1..100).days.from_now }
    class_id { rand(1..99) }
    group_id { rand(1..99) }
    content { FFaker::Lorem.sentence(3) }
    published false
    creator
    editor
  end
end