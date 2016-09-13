require 'securerandom'
require 'date'

FactoryGirl.define do
  possible_values = CmmsHelper::possible_values_per_field
  factory :cmm_properties, class: Hash do
    accessState { possible_values[:accessState].sample }
    backedBy { possible_values[:backedBy].sample }
    cmmDisplayName { Faker::Lorem.word }
    cmmHealthState { possible_values[:cmmHealthState].sample }
    dataHandle { DateTime.now.strftime('%Q') }
    description { Faker::Lorem.sentence }
    dnsHostNames { [Faker::Lorem.word] }
    domainName { Faker::Internet.domain_name }

    errorFields do
      (0..3).map do
        {
          :string => Faker::Hacker.say_something_smart,
          :errorCode => possible_values[:errorCode].sample
        }
      end
    end

    excludedHealthState { possible_values[:excludedHealthState].sample }

    firmware do
      (0..3).map do
        {
        :build => Faker::Lorem.word,
        :date => Faker::Date.backward(14),
        :name => Faker::Lorem.word,
        :role => Faker::Lorem.word,
        :status => Faker::Lorem.word,
        :type => Faker::Lorem.word,
        :version => Faker::App.version
      }
      end
    end

    FRU { Faker::Lorem.word }
    fruSerialNumber { Faker::Lorem.word }
    hostConfig do
      (0..2).map do
          {
            :DDNSenabled => possible_values[:boolean].sample,
            :DNSenabled => possible_values[:boolean].sample,
            :IPversionPriority => possible_values[:IPversionPriority].sample,
            :priIPv4userDNSserver => Faker::Internet.ip_v4_address,
            :priIPv6userDNSserver => Faker::Internet.ip_v4_address,
            :secIPv4userDNSserver => Faker::Internet.ip_v4_address,
            :secIPv6userDNSserver => Faker::Internet.ip_v4_address,
            :terIPv4userDNSserver => Faker::Internet.ip_v4_address,
            :terIPv6userDNSserver => Faker::Internet.ip_v4_address,
          }
      end
    end

    hostname { Faker::Internet.domain_name }

    ipInterfaces do
      (0..2).map do
        {
        :IPv4assignments => (0..2).map do
          {
            :address => Faker::Internet.ip_v4_address,
            :gateway => Faker::Lorem.word,
            :id => Faker::Number.number(2),
            :subnet => Faker::Internet.ip_v4_address,
            :type => possible_values[:ip_interfaces_ipv4assignments_type].sample
          }
        end,

        :IPv4DHCPmode => possible_values[:ip_interfaces_IPv4DHCPmode].sample,
        :IPv4enabled => possible_values[:boolean].sample,

        :IPv6assignments => (0..2).map do
            {
              :address => Faker::Internet.ip_v6_address,
              :gateway => Faker::Internet.ip_v4_address,
              :id => Faker::Number.number(2),
              :prefix => Faker::Number.number(2),
              :scope => possible_values[:ip_interfaces_ipv6assignments_scope].sample,
              :source => possible_values[:ip_interfaces_ipv6assignments_source].sample,
              :type => possible_values[:ip_interfaces_ipv6assignments_type].sample
            }
          end,

          :IPv6DHCPenabled => possible_values[:boolean].sample,
          :IPv6enabled => possible_values[:boolean].sample,
          :IPv6statelessEnabled => possible_values[:boolean].sample,
          :IPv6staticEnabled => possible_values[:boolean].sample,
          :label => Faker::Lorem.word,
          :name => Faker::Lorem.word
      }
      end
    end

    ipv4Addresses { [Faker::Internet.ip_v4_address, Faker::Internet.ip_v4_address] }
    ipv6Addresses { [Faker::Internet.ip_v6_address, Faker::Internet.ip_v6_address] }

    leds do
      (0..2).map do
        {
        :color => possible_values[:leds_color].sample,
        :location => possible_values[:leds_location].sample,
        :name => Faker::Lorem.word,
        :state => possible_values[:leds_state].sample
      }
      end
    end

    macAddresses { [Faker::Internet.mac_address] }
    machineType { Faker::Lorem.word }
    mgmtProcIPaddress { Faker::Internet.domain_name }
    model { Faker::Lorem.word }
    name { possible_values[:name].sample }
    overallHealthState { Faker::Lorem.word }
    parent do
      {
        :uri => Faker::Lorem.word,
        :uuid => DateTime.now.strftime('%Q')
      }
    end

    partNumber { Faker::Lorem.word }

    powerAllocation do
      {
        :maximumAllocatedPower => DateTime.now.strftime('%Q'),
        :minimumAllocatedPower => DateTime.now.strftime('%Q')
      }
    end

    productID { Faker::Number.number(3) }
    role { possible_values[:role].sample }
    serialNumber { Faker::Lorem.word }
    slots { Faker::Number.number(2) }
    type { "CMM" }
    userDescription { Faker::Lorem.sentence }
    uri { Faker::Lorem.word }
    uuid { SecureRandom.hex.upcase }

    initialize_with { attributes }
  end

end
