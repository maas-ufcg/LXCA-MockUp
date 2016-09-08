FactoryGirl.define do
  factory :cmm do
    properties { FactoryGirl.build :cmm_properties }

    after(:build) do |cmm|
      cmm._id = cmm.properties[:uuid]
    end
  end
end
