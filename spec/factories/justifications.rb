# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :justification do
    reason "MyText"
    reservation nil
    user nil
  end
end
