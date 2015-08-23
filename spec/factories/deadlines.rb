FactoryGirl.define do
  factory :deadline do
    title { FFaker::Product.product_name }
    price { rand() * 100 }
    published false
    creator
    editor
  end
end