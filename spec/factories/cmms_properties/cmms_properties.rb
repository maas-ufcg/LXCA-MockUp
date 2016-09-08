require 'securerandom'
require 'date'

FactoryGirl.define do
  access_state_values = %w(Online Offline Partial Pending Unknown)
  backed_by_values = %w(real demo proxy)
  cmm_health_state_values = %w(Normal Non-Critical Warning Minor-Failure Major-Failure Non-Recoverable Critical Unknown)

  factory :cmms_properties, class: Hash do
    accessState { access_state_values.sample }
    backedBy { backed_by_values.sample }
    cmmDisplayName { Faker::Lorem.word }
    cmmHealthState { cmm_health_state_values.sample }
    dataHandle { DateTime.now.strftime('%Q').to_i }
    description { Faker::Lorem.word }
    dnsHostNames { [Faker::Lorem.word] }


    initialize_with { attributes }
  end

end
