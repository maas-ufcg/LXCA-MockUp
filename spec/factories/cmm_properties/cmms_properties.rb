require 'securerandom'
require 'date'

FactoryGirl.define do
  possible_values = CmmsHelper::possible_values_per_field
  factory :cmm_properties, class: Hash do
    accessState { possible_values[:accessState].sample }
    backedBy { possible_values[:backedBy].sample }
    cmmDisplayName { Faker::Lorem.word }
    cmmHealthState { possible_values[:cmmHealthState].sample }
    dataHandle { DateTime.now.strftime('%Q').to_i }
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

    ipInterfaces { FactoryGirl.build :ip_interfaces }

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
        :maximumAllocatedPower => DateTime.now.strftime('%Q').to_i,
        :minimumAllocatedPower => DateTime.now.strftime('%Q').to_i
      }
    end

    productID { Faker::Number.number(3) }
    role { possible_values[:role].sample }
    serialNumber { Faker::Lorem.word }
    slots { Random.rand(20).to_i }
    type { "CMM" }
    userDescription { Faker::Lorem.sentence }
    uri { Faker::Lorem.word }
    uuid { SecureRandom.hex.upcase }

    initialize_with { attributes }
  end

end
