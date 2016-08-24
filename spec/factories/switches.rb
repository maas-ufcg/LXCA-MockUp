FactoryGirl.define do
  factory :switch do
    properties FactoryGirl.build(:switch_properties)

    after(:build) do |switch|
      switch._id =  switch.properties[:uuid]

    end

  end

  factory :inv_switch_missing_uuid do
      properties build(:switch_properties)

      after(:build) do |switch|
        switch._id =  switch.properties[:uuid]
      end

  end

  factory :inv_switch_missing_property do
    properties build(:switch_properties)

    after(:build) do |switch|
      switch._id =  switch.properties["uuid"]

      #Some important properties
      keys = %i(accessState attachedNodes cmmHealthState firmware macAddress productName serialNumber type uuid)

      selected_key = keys[Random.rand 0..9]
      switch.properties.delete(selected_key)

    end

    #properties

  end
end
