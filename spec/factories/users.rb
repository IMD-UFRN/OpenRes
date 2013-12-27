# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@imd.ufrn.br" }
    sequence(:cpf) { |n| "#{n}" * 11 }

    password "12345678"
    name "User"
    role "basic"
    sector

    factory :admin do
      email "admin@imd.ufrn.br"
      role "admin"
    end

    factory :sector_admin do
      email "sector_admin@imd.ufrn.br"
      role "sector_admin"
    end

    factory :secretary do
      email "secretary@imd.ufrn.br"
      role "secretary"
    end
  end
end
