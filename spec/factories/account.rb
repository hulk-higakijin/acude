FactoryBot.define do
  factory :account do
    email { "kanikani.zuwai@wild.com" }
    password { "kanikanizuwai" }
    password_confirmation { "kanikanizuwai" }
  end
end