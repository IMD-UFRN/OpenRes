# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "user@example.com"
    cpf "092.092.092-77"
    name "Joaquim Exemplo"
    sector
    password "rootadmin"
  end
end
