FactoryGirl.define do
  factory :ipv4_assignment, class: Hash do
    address { Faker::Internet.ip_v4_address }
    gateway { Faker::Internet.ip_v4_address }
    id { Random.rand 0...1000000 }

    subnet "255.255.255.0"
    type { %w(INUSE CONFIGURED ALIAS UNKNOWN).sample }

		initialize_with { attributes } 
  end

  factory :ipv6_assignment, class: Hash do
    address { Faker::Internet.ip_v6_address }
    gateway { Faker::Internet.ip_v6_address }
    id { Random.rand 0...1000000 }
    subnet { Faker::Internet.ip_v6_cidr }

    scope { %w(Global LinkLocal Unknown).sample }
    source { %w(DHCP Statelesss Static Other Unknown).sample }
    type { %w(INUSE CONFIGURED ALIAS UNKNOWN).sample }

		initialize_with { attributes } 
  end
end
