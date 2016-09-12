FactoryGirl.define do
  factory :cmm do
    properties { FactoryGirl.build :cmm_properties }

    after(:build) do |cmm|
      cmm._id = cmm.properties[:uuid]
    end
  end

  CmmsHelper::required_fields.each do |key|
     factory :"no_#{key}_cmm", class: Cmm do
       properties { FactoryGirl.build(:cmm_properties) }

       
        after :build do |cmm|
           cmm._id = cmm.properties[:uuid]
           cmm.properties.delete(key)
         end

     end
   end
end
