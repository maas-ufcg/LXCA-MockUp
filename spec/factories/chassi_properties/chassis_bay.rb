FactoryGirl.define do

  factory :chassis_bay, class: Hash do
    isExceeded { ["N", "Y"].sample }
    sensorName { Faker::Lorem.word }
    sensorValue {  Random.rand.to_f  }
    slot { Random.rand 0...10 }
    subSlot { Random.rand 0...10 }

    initialize_with { attributes }

  end
end
