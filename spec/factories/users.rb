FactoryBot.define do
  factory :user do
    trait :set_user do
        role {role}
        status {:active}
        created_at {"2020-09-06 05:48:12"}
    end
    name {Faker::Movies::HarryPotter.character}
    email {Faker::Internet.email}
    status {Faker::Number.between from: 0, to: 1}
    created_at {Faker::Date.between(from: "1970-09-23", to: "2010-08-25")}
    updated_at {Faker::Date.between(from: "1970-09-23", to: "2010-08-25")}
    role {Faker::Number.between from: 0, to: 1}
    avatar {Rack::Test::UploadedFile.new(Rails.root.join("spec/support/fixture/default.jpg"))}
    password {"Minhthong511"}
  end
end
