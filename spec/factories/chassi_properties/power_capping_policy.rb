FactoryGirl.define do
  power_capping_policy = [
    "OFF",
    "STATIC",
    "UNKNOWN"
  ]

  factory :power_capping_policy, class Hash do
    cappingPolicy { power_capping_policy.sample }
    currentPowerCap { rand(2**32..2**64-1) }
    maxPowerCap { rand(2**32..2**64-1) }
    minPowerCap { rand(2**32..2**64-1) }
  end
end
