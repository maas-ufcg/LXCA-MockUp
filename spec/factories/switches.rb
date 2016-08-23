FactoryGirl.define do
  factory :switch do
    properties FactoryGirl.build(:switch_properties)

    after(:build) do |switch|
      switch._id =  switch.properties["uuid"]

    end

  end

  factory :inv_switch_missing_uuid do
      properties build(:switch_properties)
      after(:build) do |switch|
        switch._id =  switch.properties["uuid"]
        switch.properties.remove("uuid")
      end

  end

  factory :inv_switch_missing_property do
    properties build(:switch_properties)

    after(:build) do |switch|
      switch._id =  switch.properties["uuid"]

    end

    #properties

  end
end
