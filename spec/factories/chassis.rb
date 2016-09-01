FactoryGirl.define do

  factory :chassi do
    properties { FactoryGirl.build :chassi_properties }

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

   factory :chassi_valid_put_request_properties, class: Hash do
     cmmDisplayName { Faker::Hipster.sentence }
     contact { Faker::Hipster.sentence(4) }
     domainName { Faker::Hipster.sentence(1) }
     hostname { Faker::Hipster.sentence(1) }
     location do
       {
         :location => "#{Faker::Number.number(8)}",
         :lowestRackUnit => Faker::Number.number(2),
         :rack => "#{Faker::Hipster.sentence(2)}",
         :room => "#{Faker::Hipster.sentence(3)}"
       }
     end
     userDescription { Faker::Hacker.say_something_smart }

     initialize_with { attributes }
   end

   factory :chassi_valid_put_request_policy, class: Hash do
     securityPolicy do
       {
         :cmmPolicyLevel => %W(LEGACY SECURE).sample,
         :cmmPolicyState =>  %W(ERROR UNKNOWN ACTIVE PENDING).sample
       }
     end

     initialize_with { attributes }
   end

   factory :chassi_valid_put_request_led, class: Hash do
     leds {
       (0..3).map do
         {
           :name => Faker::Hipster.sentence(1),
           :state => %w(Off On Blinking Unknown).sample,
           :color => %w(Red Amber Yellow Green Blue Unknown).sample,
           :location => ["Red", "Amber", "Yellow", "Green", "Blue", "Unknown"].sample
         }
     end
     }
   end

   factory :chassi_valid_put_request_cmm, class: Hash do
     cmmFailover { [true, false].sample }

     initialize_with { attributes }
   end

   factory :chassi_valid_put_request_tls, class: Hash do
     nist do
       {
         :currentValue => %w(
                            Unknown
                            Compatibility
                            Nist_800_131A_Strict
                            Nist_800_131A_Custom
                            ).sample,
        :possibleValues => %w(
          Unknown
          Compatibility
          Nist_800_131A_Strict
          Nist_800_131A_Custom
        )
       }
     end

     tlsVersion do
       {
         :currentValue => %w(
                            Unknown
                            SSL_30
                            TLS_10
                            TLS_11
                            TLS_12
                            TLS_12_Server_Client
                            TLS_12_Server).sample
       }
     end

     initialize_with { attributes }
   end

   factory :chassi_valid_put_request_encapsulation_mode, class: Hash do
     encapsulationMode {
                         %w(
                           notSupported
                           normal
                           encapsulationLite
                           ).sample
                      }
                      initialize_with { attributes }
   end

end
