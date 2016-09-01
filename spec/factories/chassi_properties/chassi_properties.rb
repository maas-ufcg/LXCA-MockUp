require 'securerandom'
require 'date'

FactoryGirl.define do

  access_state = %w(
    Online
    Offline
    Partial
    Pending
    Unknown
  )

  overall_health_state = %w(Normal Non-Critical Warning Minor-Failure Major-Failure Non-Recoverable Critical Unknown)

  severity_values = %W(
    FATAL
    CRITICAL
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

  error_fields = %w(
    FETCH_SUCCESS
    FETCH_FAILED
    NO_CONNECTOR
    FATAL_EXCEPTION
    NETWORK_FAIL
  )

  led_colors = %w(Red Amber Yellow Green Blue Unknown)
  led_states = %w(Off On Blinking Unknown)

  led_locations = [
    "Front panel",
    "Lightpath Card",
    "Planar",
    "FRU",
    "Rear Panel",
    "Unknown"
  ]

  nist_possible_values = %W(
    Unknown
    Compatibility
    Nist_800_131A_Strict
    Nist_800_131A_Custom
  )

  tls_possible_values = %W(
      Unknown
      SSL_30
      TLS_10
      TLS_11
      TLS_12
      TLS_12_Server_Client
      TLS_12_Server
    )

    tempVar = encapsulation_mode.sample

  factory :chassi_properties, class: Hash do
    accessState { access_state.sample }
    activationKeys [] #review this parameters
    activeAlerts do
      (1..10).map do |active_alerts_id|
        {
          :corrIDs => "", #review_this_parameters
          :id => "#{active_alerts_id}",
          :location => "#{Faker::Number.number(8)}",
          :msg => Faker::Hipster.sentence(5),
          :msgId => "CMM#{Faker::Number.number(4)}",
          :severity => severity_values.sample
        }
      end
    end

    backedBy { backed_by.sample }
    bladeSlots { Faker::Number.number(2).to_i }
    cmmDisplayName { Faker::Hipster.sentence(1) }
    cmmHealthState { cmm_health_states.sample }
    cmms [] #review_this_parameters: Information about a other resource
    cmmSlots { Faker::Number.number(2).to_i }
    complex [] #review_this_parameters: Information about a other resource
    contact { Faker::Hipster.sentence(4) }
    dataHandle { DateTime.now.strftime('%Q').to_i }
    description { Faker::Hipster.sentence(4) }
    domainName { "Lenovo-#{Faker::Number.number(7)}" }
    encapsulation do
      {
        :encapsulationMode => encapsulation_mode.sample
        #:nonBlockedIpAddressList => Esse atributo é setado
        #só depois do mock das propriedades feito.
      }
    end

    # if tempVar.eql? "encapsulationLite"
    #   encapsulation[0][:blocked_ip_list] = FactoryGirl.build :nonBlockedIpAddressList
    # end

    energyPolicies { FactoryGirl.build :energy_policies }
    errorFields do
      (0..3).map do
        {
          :string => Faker::Hacker.say_something_smart,
          :errorCode => error_fields.sample
        }
      end
    end
    excludedHealthState { cmm_health_states.sample }
    fanMuxes [] #review_this_parameter: Will re-use the fanMuxes factory.
    fanMuxSlots { Faker::Number.number(2).to_i }
    fans [] #review_this_parameter: Will re-use the fans factory
    fanSlots { Faker::Number.number(2).to_i }
    height { Faker::Number.number(2).to_i }
    hostname { Faker::Hipster.sentence(1) }
    isConnectionTrusted {  [true, false].sample }
    ledCardSlots { Faker::Number.number(2).to_i }

    leds do
      (0..10).map do
        {
          :color => led_colors.sample,
          :location => led_locations.sample,
          :name => Faker::Hipster.sentence(1),
          :state => led_states.sample
        }
      end
    end

    location do
      {
        :location => Faker::Address.state,
        :lowestRackUnit => Faker::Number.number(1).to_i,
        :rack => Faker::Hipster.sentence(1),
        :room => Faker::Hipster.sentence(1)
      }
    end

    machineType { Faker::Hipster.sentence(1) }
    managerName "UNKNOWN" #The value is always set to "UNKNOWN"
    managerUuid "UNKNOWN" #The value is always set to "UNKNOWN"
    manufacturer { Faker::Hipster.sentence(1) }
    manufacturerID { Faker::Number.number(3) }
    mgmtProcIPaddress { Faker::Internet.ip_v4_address }
    model { Faker::Hipster.sentence(1) }

    #   The chassis name, if available.
    #   Otherwise, this is one of the following values:
    # -   DNS host name of the CMM if available.
    # -   User-defined host name if available.
    # -   IP address of the CMM if available.
    # -   Component name of the chassis if available.
    # -   Serial number of the chassis.
    name { Faker::Number.number(10) }

    nist do
      {
        :currentValue => nist_possible_values.sample,
        :possibleValues => nist_possible_values
      }
    end

    nodes [] #review_this_parameter: Will re-use Nodes factory
    partNumber { Faker::Number.number(5) }
    passThroughModules [] #review_this_parameter: Will re-use Switches factory
    posID { Faker::Number.number(4) }
    powerAllocation do
      {
        :allocatedOutputPower => Faker::Number.number(4).to_i,
        :totalOutputPower => Faker::Number.number(4).to_i,
        :totalInputPower => Faker::Number.number(5).to_i,
        :remainingOutputPower => Faker::Number.number(4).to_i,
        :midPlaneCardMinimumAllocatedPower => Faker::Number.number(2).to_i.to_i,
        :midPlaneCardMaximumAllocatedPower => Faker::Number.number(2).to_i
      }
    end

    powerSupplySlots { Faker::Number.number(1).to_i }
    powerSupplies [] #review_this_parameter: Will re-use powerSupplies Factory
    productID { Faker::Number.number(8).to_s }
    overallHealthState { overall_health_state.sample }

    securityPolicy do
      {
        :cmmPolicyLevel => %W(LEGACY SECURE).sample,
        :cmmPolicyState => %W(ERROR UNKNOWN ACTIVE PENDING).sample,
      }
    end

    serialNumber { Faker::Number.number(8).to_s }
    status do
      {
        :message => "MANAGED",
        :name => "MANAGED"
      }
    end

    switches [] #review_this_parameter: Will re-use Switches FactoryGirl
    switchSlots { Faker::Number.hexadecimal(14).to_i }

    tlsVersion do
      {
        :currentValue => tls_possible_values.sample,
        :possibleValues => tls_possible_values
      }
    end

    type "Chassis" #This value is always "Chassis"
    userDescription { Faker::Hacker.say_something_smart }
    uri { "chassis/#{uuid}" }
    uuid { SecureRandom.hex.upcase }
    vpdID { Faker::Number.number(2) }



    after(:create) do |chassi_properties|
      chassi_properties[:nonBlockedIpAddressList] = FactoryGirl.build :blocked_ip_list unless chassi_properties[:encapsulationMode] != "encapsulationLite"
    end

   initialize_with { attributes }

  end

  factory :blocked_ip_list, class: Hash do
    nonBlockedIpAddressList do
      (0..10).map do
        Faker::Internet.ip_v4_address
      end
    end

    initialize_with { attributes }
  end


end
