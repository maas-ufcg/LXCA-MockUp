FactoryGirl.define do
  possible_values = CmmsHelper::possible_values_per_field

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

   factory :cmm_valid_put_request_properties, class: Hash do
     domainName { Faker::Internet.domain_name }
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

     initialize_with { attributes }
   end

   factory :cmm_invalid_put_request_properties, class: Hash do
     encapsulation do
       { :hostConfig => Faker::Number.number(2) }
     end


      initialize_with { attributes }
   end


end
