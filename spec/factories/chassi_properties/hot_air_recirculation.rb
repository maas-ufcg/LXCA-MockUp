FactoryGirl.define do

  factory :hot_air_recirculation, class: Hash do
    chassisBay do
      (0...5).map do
          FactoryGirl.build :chassis_bay
      end
    end

    isEnabled { [true, false].sample }
    maxVariation { Random.rand.to_f }

    initialize_with { attributes }
  end
end
