# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :object_resource do
    name "MyString"
    description "MyText"
    sector nil
    place nil
    serial_number "MyString"
  end
end
