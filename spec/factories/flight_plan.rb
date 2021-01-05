FactoryBot.define do
  factory :flight_plan do

    trait :with_directions do
      transient do
        directions_count { 1 }
      end

      after(:create) do |flight_plan, evaluator|
        create_list(:direction, evaluator.directions_count, flight_plan: flight_plan)
        flight_plan.reload
      end
    end

  end
end