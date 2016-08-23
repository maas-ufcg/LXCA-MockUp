require 'securerandom'

FactoryGirl.define do
  access_state = %w(
    Online
    Offline
    Partial
    Pending
    Unknown
  )

  severity = %(
    FATAL
    CRITIAL
    MAJOR
    MINOR
    WARNING
    INFORMATIONAL
    UNKNOWN
  )

  backed_by = %w(
    real
    demo
    proxy
  )

  cmm_health_states = %w(
    Normal
    Non-Critical
    Warning
    Minor-Failure
    Major-Failure
    Non-Recoverable
    Critical
    Unknown
  )

  encapsulation_mode = %w(
    notSupported
    normal
    encapsulationLite
  )

  is_enabled = [true, false]

  factory :chassi_properties, class: Hash do
    energyPolicies { FactoryGirl.build :energy_policies }
    errorFields { [  ] }




  end




end
