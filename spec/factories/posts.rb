FactoryBot.define do
  factory :post do
    title { "Sample Post Title" }
    content { "This is a sample post content." }
    association :user

    factory :invalid_post do
      title { nil }
    end
  end
end
