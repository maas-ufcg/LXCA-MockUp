FactoryGirl.define do
  factory :canister, aliases: [:valid_canister] do
    properties { build :canister_properties }
    after :build do |canister|
      canister._id = canister.properties[:uuid]
    end
  end

    CanistersHelper::required_fields.each do |field|
      factory :"no_#{field}_canister", class: Canister do
        properties { FactoryGirl.build :canister_properties }
        after :build do |canister|
          canister._id = canister.properties[:uuid]
          canister.properties.delete(field)
        end


      end

      factory :"nil_#{field}_canister", class: Canister do
        properties { FactoryGirl.build :canister_properties }
        after :build do |canister|
          canister._id = canister.properties[:uuid]
          canister.properties[field] = nil
        end


      end

      factory :"empty_string_#{field}_canister", class: Canister do
        properties { FactoryGirl.build :canister_properties }
        after :build do |canister|
          canister._id = canister.properties[:uuid]
          canister.properties[field] = ""
        end
      end
    end
end
