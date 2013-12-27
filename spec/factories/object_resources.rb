# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :object_resource do
    name "Projetor X"
    description "Projetor Samsung modelo X e cor branca."
    sector 
    place 
    serial_number "1234123456"
  end
end
