FactoryGirl.define do
  factory :fan, aliases: [:valid_fan] do
    after :build do |fan|
      fan._id = fan.properties[:uuid]
    end

    properties { FactoryGirl.build :fan_properties }
  end

  FansHelper::required_fields.each do |field|
    factory :"no_#{field}_fan", class: Fan do
      after :build do |fan|
        fan._id = fan.properties[:uuid]
        fan.properties.delete(field)
      end

      properties { FactoryGirl.build :fan_properties }
    end

    factory :"nil_#{field}_fan", class: Fan do
      after :build do |fan|
        fan._id = fan.properties[:uuid]
        fan.properties[field] = nil
      end

      properties { FactoryGirl.build :fan_properties }
    end

    factory :"empty_string_#{field}_fan", class: Fan do
      after :build do |fan|
        fan._id = fan.properties[:uuid]
        fan.properties[field] = ""
      end

      properties { FactoryGirl.build :fan_properties }
    end
  end
end
