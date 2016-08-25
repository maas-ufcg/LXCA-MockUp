FactoryGirl.define do
  factory :switch, aliases: [:valid_switch]  do
    properties {FactoryGirl.build(:switch_properties)}

    after(:build) do |switch|
      switch._id =  switch.properties[:uuid]

    end

  end

  factory :inv_switch_different_id_and_uuid, class: Switch do
      properties {FactoryGirl.build(:switch_properties)}

       after(:build) do |switch|
         switch._id =  "alohomora"

       end

  end

  SwitchesHelper::required_fields.each do |key|

     factory :"no_#{key}_switch", class: Switch do
        after :build do |switch|
           switch._id = switch.properties[:uuid]
           switch.properties.delete(key)
         end

          properties {FactoryGirl.build(:switch_properties)}
     end


     factory :"nil_#{key}_switch", class: Switch do
      after :build do |switch|
        switch._id = switch.properties[:uuid]
        switch.properties[key] = nil
      end

      properties {FactoryGirl.build(:switch_properties)}
    end

    factory :"empty_#{key}_switch", class: Switch do
     after :build do |switch|
       switch._id = switch.properties[:uuid]
       switch.properties[key] = ""
     end

     properties {FactoryGirl.build(:switch_properties)}
   end

  end

  # => TODO: DEBUG 
  # factory :switches_put_request_settings, aliases: [:switch_put_settings_request], class: Hash do
  #
  #   hostname do
  #     Faker::Internet.domain_name
  #   end
  #   ipv4Address do
  #     (0..1).map do |number|
  #       Faker::Internet.ip_v4_address
  #     end
  #   end
  #
  #   location do
  #     {
  #       :location =>  Faker::Lorem.word ,
  #       :contact =>  Faker::Company.name
  #     }
  #   end
  #   ipv6Address do
  #     (0..1).map do |number|
  #       Faker::Internet.ip_v4_address
  #     end
  #   end
  #
  # end

end
