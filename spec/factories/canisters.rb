FactoryGirl.define do
  factory :canister, aliases: [:valid_canister] do
    after :build do |canister|
      canister._id = canister.properties[:uuid]
    end

    properties { FactoryGirl.build : canister_properties }
end
