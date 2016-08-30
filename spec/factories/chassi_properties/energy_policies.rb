FactoryGirl.define do

  accoustic_attenuation_mode = [
    "Off",
    "Least attenuation",
    "Low level attenuation",
    "Mid level attenuation",
    "High level attenuation",
    "Most attenuation",
    "Unknown"
  ]

  factory :energy_policies, class: Hash do
    accousticAttenuationMode { accoustic_attenuation_mode.sample }
    hotAirRecirculation { FactoryGirl.build :hot_air_recirculation }
    powerCappingPolicy { FactoryGirl.build :power_capping_policy }
    powerRedundancyMode { Faker::Number.number(5).to_i  }

              initialize_with { attributes }
  end
end
