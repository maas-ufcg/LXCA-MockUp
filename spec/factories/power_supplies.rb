
FactoryGirl.define do

  factory :power_supply do
    properties { FactoryGirl.build :power_supply_properties }

    after(:build) do |power_supply|
      power_supply._id = power_supply.properties[:uuid]
    end
  end

  factory :invalid_cmm_health_state_power_supply do
    properties build(:power_supply_properties)

    after(:build) do |power_supply|
      power_supply._id = power_supply.properties[:uuid]
    end
  end

end
