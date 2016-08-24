FactoryGirl.define do


  factory :chassi do
    properties FactoryGirl.build :chassi_properties

    after(:build) do |chassi|
      chassi._id = chassi.properties['uuid']
    end

  end
end
