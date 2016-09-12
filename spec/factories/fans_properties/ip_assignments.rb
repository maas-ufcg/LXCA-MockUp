FactoryGirl.define do
  factory :ipv4_assignment, class: Hash do
    id { Random.rand 0...1000000 }
    subnet "255.255.255.0"
    address { Faker::Internet.ip_v4_address }
    gateway { Faker::Internet.ip_v4_address }
    type { %w(INUSE CONFIGURED ALIAS UNKNOWN).sample }

		initialize_with { attributes }
  end

  factory :ipv6_assignment, class: Hash do
    id { Random.rand 0...1000000 }
    scope { %w(Global LinkLocal Unknown).sample }
    source { %w(DHCP Statelesss Static Other Unknown).sample }
    gateway { Faker::Internet.ip_v6_address }
    address { Faker::Internet.ip_v6_address }
    subnet { Faker::Internet.ip_v6_cidr }
    type { %w(INUSE CONFIGURED ALIAS UNKNOWN).sample }

		initialize_with { attributes }
  end
end
