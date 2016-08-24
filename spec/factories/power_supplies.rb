
FactoryGirl.define do

  factory :power_supply do
    properties { FactoryGirl.build :power_supply_properties }

    after(:build) do |power_supply|
      power_supply._id = power_supply.properties[:uuid]
    end
  end

  factory :inv_power_supply_missing_uuid, class: PowerSupply do
    properties {FactoryGirl.build(:power_supply_properties)}

    after(:build) do |power_supply|
      power_supply._id =  power_supply.properties[:uuid]
      power_supply.properties.delete(:uuid)
    end
  end

  PowerSuppliesHelper::required_fields.each do |key|

    factory :"no_#{key}_power_supply", class: PowerSupply do
      after :build do |power_supply|
        power_supply._id = power_supply.properties[:uuid]
        power_supply.properties.delete(key)
      end

      properties {FactoryGirl.build(:power_supply_properties)}
    end


    factory :"nil_#{key}_power_supply", class: PowerSupply do
      after :build do |power_supply|
        power_supply._id = power_supply.properties[:uuid]
        power_supply.properties[key] = nil
      end

      properties {FactoryGirl.build(:power_supply_properties)}
    end

    factory :"empty_#{key}_power_supply", class: PowerSupply do
      after :build do |power_supply|
        power_supply._id = power_supply.properties[:uuid]
        power_supply.properties[key] = ""
      end

      properties {FactoryGirl.build(:power_supply_properties)}
    end

  end

end
