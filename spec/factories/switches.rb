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

  SwitchesHelper::defined_fields.each do |key|

   factory :"invalid_#{key}_switch", class: Switch do

     properties {FactoryGirl.build(:switch_properties)}
     after (:build) do |switch|
       switch._id = switch.properties[:uuid]
       switch.properties[key] = "From lemonades to lemons. Waaat?"
     end

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

  factory :switches_valid_put_request_settings, class: Hash do

    hostname { Faker::Internet.domain_name }


    ipv4Address do
      (0..1).map do |number|
        Faker::Internet.ip_v4_address
      end
    end

    location do
      {
        :location =>  Faker::Lorem.word ,
        :contact =>  Faker::Company.name
      }
    end
    ipv6Address do
      (0..1).map do |number|
        Faker::Internet.ip_v4_address
      end
    end

    initialize_with { attributes }
  end


  factory :switches_valid_put_request_powerState, class: Hash do

    powerState %w(powerOn powerOff powerCycleSoft virtualReseat).sample

    initialize_with { attributes }
  end

  factory :switches_valid_put_request_refreshInventory, class: Hash do

    refreshInventory {Faker::Lorem.word}

    initialize_with { attributes }
  end

  factory :switches_valid_put_request_leds, class: Hash do

    leds do
      {
        :name => Faker::Lorem.word,
        :state => %w(off on blinking)
      }
    end

    initialize_with { attributes }
  end

  #TODO: TOFIX: invalid_fields doesn't exist in helper.
  # SwitchesHelper::invalid_fields.each do |key|
  #
  #   factory :"invalid_#{key}_switch", class: Switch do
  #     after :build do |switch|
  #       switch._id = switch.properties[:uuid]
  #       switch.properties[key] = "From lemonades to lemons."
  #     end
  #   end
  #
  # end

end
