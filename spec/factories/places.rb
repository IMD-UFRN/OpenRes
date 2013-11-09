# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :place do
    name "MyString"
    description "MyText"
    code "MyString"
    capacity 1
    sector nil
    room_type nil
  end
end
