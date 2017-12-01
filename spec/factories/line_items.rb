FactoryGirl.define do
  factory :line_item do
    book { build(:book) }
    cart { build(:cart) }
    price { book.price }
    quantity 1
  end
end
