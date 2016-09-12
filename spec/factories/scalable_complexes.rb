FactoryGirl.define do
	factory :scalable_complex, aliases: [:valid_scalableComplex] do
		properties {FactoryGirl.build(:scalable_complex_properties)}

		after :build do |scalableComplex|
			scalableComplex._id = scalableComplex.properties[:uuid]
		end
	end

	factory :inv_scalableComplex_different_id_and_uuid, class ScalableComplex do
		properties {FactoryGirl.build (:scalable_complex_properties)}

		after(:build) do |scalableComplex|
			scalableComplex._id = Faker::Pokemon.name
		end

	end

	ScalableComplexHelper::required_fields.each do |key|
		factory :"no_#{key}_scalableComplex", class ScalableComplex do

			properties {FactoryGirl.build(:scalable_complex_properties)}

			after :build do |scalableComplex|
				scalableComplex._id = scalableComplex.properties[:uuid]
				scalableComplex.properties.delete(key)
			end
		end

		factory :"nil_#{key}_scalableComplex", class ScalableComplex do
			after :build do |scalableComplex|
				scalableComplex._id = scalableComplex.properties[:uuid]
				scalableComplex.properties[key] = nil
			end
			properties {FactoryGirl.build(:scalable_complex_properties)}
		end

		factory :"empty_#{key}_scalableComplex", class ScalableComplex do
			after :build do |scalableComplex|
				scalableComplex._id = scalableComplex.properties[:uuid]
				scalableComplex.properties[key] = ""
			end
			properties {FactoryGirl.build(:scalable_complex_properties)}
		end

	end

end
