require 'securerandom'

FactoryGirl.define do
  health_states = %w(
    Normal
    Non-Critical
    Warning
    Minor-Failure
    Major-Failure
    Non-Recoverable
    Critical
    Unknown
  )

  led_colors = %w(Red Amber Yellow Green Blue Unknown)
  led_locations = [
    "Front panel",
    "Lightpath Card",
    "Planar",
    "FRU",
    "Rear Panel",
    "Unknown"
  ]
  led_states = %w(Off On Blinking Unknown)
  power_states = %w(Off On ShuttingDown Standby Hibernate Unknown)

  factory :switch_properties, class: Hash do
    accessState { %w(Online Offline Partial Pending Unknown).sample }
    applyPending { Random.rand 0..3 } #TODO: documentation inconsistency
    attachedNodes [] #TODO: documentation inconsistency
    cmmDisplayName { Faker::Hipster.word }
    cmmHealthState { health_states.sample }
    contact { Faker::Company.name }
    cpuUtilization { Random.rand * 100 }
    dataHandle  { Random.rand 0...2**61 }
    description { Faker::Company.catch_phrase }
    dnsHostnames do
      (0...Random.rand(0..5)).map { Faker::Internet.domain_name }
    end
    domainName { Faker::Internet.domain_name }
    entitleSerialNumber "" #TODO: documentation inconsistency
    errorFields [] #TODO: documentation inconsistency
    excludedHealthState { health_states.sample }
    fans do
      (1..10).map do |fan_id|
        {
          "fanName" => "Fan #{fan_id}",
          "fanSpeed" => "#{Random.rand 5000..15000} RPM (60 PWM)",
          "fanState" => Faker::Lorem.sentence
        }
      end
    end
    firmware do
      {
        "build" => Faker::App.version,
        "date" => Faker::Time.between(DateTime.now - 3650, DateTime.now).to_s.split.first,
        "name" => "#{Faker::App.name} firmware",
        "status" => "",
        "type" => "",
        "version" => Faker::App.version
      }
    end
    FRU "" #TODO: documentation inconsistency
    fruSerialNumber "" #TODO: documentation inconsistency
    hostname { Faker::Internet.domain_name }
    ipInterfaces { FactoryGirl.build :ip_interfaces }
    ipv4Address do
      (0..10).map do |number|
        Faker::Internet.ip_v4_address
      end
    end
    ipv6Address do
      (0..10).map do |number|
        Faker::Internet.ip_v6_address
      end
    end
    leds do
      (0..5).map do |number|
        {
          "color" => led_colors.sample,
          "location" => led_locations.sample,
          "name" => Faker::Lorem.word,
          "state" => led_states.sample
        }
      end
    end
    macAddress do
      (0..5).map { |number| Faker::Internet.mac_address }
    end
    machineType { Random.rand 0...2**61 }
    manufacturer ""
    manufacturerID ""
    manufacturingDate { "#{Random.rand 0...10000}" }
    memoryUtilization do
      total = Random.rand 0...2**61
      "Total : #{total} Free : #{total/2}"
    end
    model "" #TODO: documentation inconsistency
    name { Faker::Hipster.word }
    overallHealthState { health_states.sample }
    panicDump { %w(Yes No).sample }
    ports do
      (0..10).map do |number|
        {
          "portName" => "#{number}",
          "portSpeed" => %w(mbs1000 mbs40000),
          "portState" => "",
          "PVID" => "#{number}",
          "tagPVID" => "untagged",
          "vLAN" => "untagged"
        }
      end
    end
    posID "" #TODO: documentation inconsistency
    powerState { power_states.sample }
    productID "" #TODO: documentation inconsistency
    productName { Faker::App.name }
    protectedMode { [true, false].sample }
    resetReason ""
    savePending { %w(yes no).sample }
    serialNumber { "US#{Random.rand 1000...100000}S"}
    slots 1 #TODO: documentation inconsistency
    stackMode { [true, false].sample }
    stackRole "" #TODO: documentation inconsistency
    sysObjectID { Faker::App.version }
    temperatureSensors do
      (1..Random.rand(1..10)).map do |sensor|
        {
          "sensorName" => "Sensor #{sensor}",
          "sensorState" => "#{Random.rand*100}"
        }
      end
    end
    type "Switch"
    upTime { Random.rand 1000...100000 }
    uri { Faker::Internet.url }
    userDescription { Faker::Lorem.sentence }
    uuid { SecureRandom.uuid }
    vpdID "" #TODO: documentation inconsistency

		initialize_with { attributes }
  end
end

