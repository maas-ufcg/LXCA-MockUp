FactoryGirl.define do


  factory :chassi do
    properties FactoryGirl.build :chassi_properties

    after(:build) do |chassi|
      chassi._id = chassi.properties[:uuid]
    end
  end

  ChassisHelper::required_fields.each do |key|

     factory :"no_#{key}_chassi", class: Chassi do
        after :build do |chassi|
           chassi._id = chassi.properties[:uuid]
           chassi.properties.delete(key)
         end

          properties { FactoryGirl.build(:chassi_properties) }
     end
   end


end
