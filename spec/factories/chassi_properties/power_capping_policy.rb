FactoryGirl.define do
  power_capping_policy = [
    "OFF",
    "STATIC",
    "UNKNOWN"
  ]

  factory :power_capping_policy, class: Hash do
    cappingPolicy { power_capping_policy.sample }
    currentPowerCap { Faker::Number.number(5).to_i }
    maxPowerCap { Faker::Number.number(5).to_i }
    minPowerCap { Faker::Number.number(5).to_i  }

    initialize_with { attributes }
  end
end
