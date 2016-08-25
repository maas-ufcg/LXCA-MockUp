FactoryGirl.define do
  factory :fan_mux, aliases: [:valid_fan_mux] do
    after :build do |fan_mux|
      fan_mux._id = fan_mux.properties[:uuid]
    end

    properties { FactoryGirl.build :fan_mux_properties }
  end

  FanMuxesHelper::required_fields.each do |field|
    factory :"no_#{field}_fan_mux", class: FanMux do
      after :build do |fan_mux|
        fan_mux._id = fan_mux.properties[:uuid]
        fan_mux.properties.delete(field)
      end

      properties { FactoryGirl.build :fan_mux_properties }
    end

    factory :"nil_#{field}_fan_mux", class: FanMux do
      after :build do |fan_mux|
        fan_mux._id = fan_mux.properties[:uuid]
        fan_mux.properties[field] = nil
      end

      properties { FactoryGirl.build :fan_mux_properties }
    end

    factory :"empty_string_#{field}_fan_mux", class: FanMux do
      after :build do |fan_mux|
        fan_mux._id = fan_mux.properties[:uuid]
        fan_mux.properties[field] = ""
      end

      properties { FactoryGirl.build :fan_mux_properties }
    end
  end
end
