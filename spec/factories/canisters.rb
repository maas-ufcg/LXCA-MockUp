FactoryGirl.define do
  factory :canister, aliases: [:valid_canister] do
    after :build do |canister|
      canister._id = canister.properties[:uuid]
    end

    properties { FactoryGirl.build :canister_properties }
  end
    CanistersHelper::required_fields.each do |field|
      factory :"no_#{field}_canister", class: Canister do
        after :build do |canister|
          canister._id = canister.properties[:uuid]
          canister.properties.delete(field)
        end

        properties { FactoryGirl.build :canister_properties }
      end

      factory :"nil_#{field}_canister", class: Canister do
        after :build do |canister|
          canister._id = canister.properties[:uuid]
          canister.properties[field] = nil
        end

        properties { FactoryGirl.build :canister_properties }
      end

      factory :"empty_string_#{field}_cansiter", class: Canister do
        after :build do |canister|
          canister._id = canister.properties[:uuid]
          canister.properties[field] = ""
        end

        properties { FactoryGirl.build :canister_properties }
      end
      
    end
end
