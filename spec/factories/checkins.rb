# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :checkin do
    place nil
    reservation nil
    start_time "2014-04-13 00:01:31"
    end_date "2014-04-13 00:01:31"
  end
end
