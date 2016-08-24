FactoryGirl.define do
  factory :fan do
    after :build do |fan|
      fan._id = fan.properties[:uuid]
    end

    properties { FactoryGirl.build :fan_properties }
  end
end
