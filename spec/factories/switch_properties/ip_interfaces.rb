FactoryGirl.define do
  factory :ip_interfaces, class: Hash do
		IPv4Assignments do
      (0...(Random.rand 0...10)).map do |n_ipv4|
        FactoryGirl.build :ipv4_assignment
      end
		end

		IPv6Assignments do
      (0...(Random.rand 0...10)).map do |n_ipv6|
        FactoryGirl.build :ipv6_assignment
      end
		end

    IPv4DHCPmode { %w(STATIC_ONLY DHCP_ONLY DHCP_THEN_STATIC UNKNOWN).sample }

    IPv4enabled { [true, false].sample }
    IPv6DHCPenabled { [true, false].sample }
    IPv6enabled { [true, false].sample }
    IPv6statelessEnabled { [true, false].sample }
    IPv6staticEnabled	 { [true, false].sample }

    label { Faker::Lorem.word }
    name { Faker::Hipster.word }

		initialize_with { attributes } 
  end
end
