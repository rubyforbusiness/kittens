FactoryBot.define do
  factory :direction do
    trait :with_flight_plan do
      flight_plan
    end
  end
end