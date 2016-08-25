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

  SwitchesHelper::invalid_fields.each do |key|

    factory :"invalid_#{key}_switch", class: Switch do
      after :build do |switch|
        switch._id = switch.properties[:uuid]
        switch.properties[key] = "From lemonades to lemons."
      end
    end
    
  end


end
