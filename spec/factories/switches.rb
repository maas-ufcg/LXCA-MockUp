FactoryGirl.define do
  factory :switch do
    properties {FactoryGirl.build(:switch_properties)}

    after(:build) do |switch|
      switch._id =  switch.properties[:uuid]

    end

  end

  factory :inv_switch_missing_uuid, class: Switch do
      properties {FactoryGirl.build(:switch_properties)}

       after(:build) do |switch|
         switch._id =  switch.properties[:uuid]
         switch.properties.delete(:uuid)
       end

  end


  factory :inv_switch_different_id_and_uuid, class: Switch do
    properties {FactoryGirl.build(:switch_properties)}

    after(:build) do |switch|
      switch._id =  "alohomora"
    end


  end

  factory :inv_switch_missing_property, class: Switch do
    properties {FactoryGirl.build(:switch_properties)}

    after(:build) do |switch|
      switch._id =  switch.properties[:uuid]

      #Some important properties
      keys = 	SwitchesHelper::required_fields

      selected_key = keys[Random.rand 0..9]
      switch.properties.delete(selected_key)

    end

    #properties

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



end
