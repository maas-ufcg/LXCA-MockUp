FactoryGirl.define do
  factory :cmms do
    properties { FactoryGirl.build :cmms_properties }

    after(:build) do |cmms|
      cmms._id = cmms.properties[:uuid]
    end
  end
end
