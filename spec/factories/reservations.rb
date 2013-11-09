# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation do
    begin_time "2013-11-08 23:55:48"
    end_time "2013-11-08 23:55:48"
    status "Pendding"
    user 
    place 
  end
end
