FactoryGirl.define do
  factory :switch_properties, class: Hash do
    ipInterfaces { Factory :ip_interfaces }

		initialize_with { attributes } 
  end
end
