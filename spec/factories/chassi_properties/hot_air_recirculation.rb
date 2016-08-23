FactoryGirl.define do

  factory :hot_air_recirculation, class Hash do
    chassisBay [ FactoryGirl.build :chassis_bay ]

    isEnabled { [true, false].sample }
    maxVariation { Random.rand.to_f }


    initialize_with { attributes }
  end
end
