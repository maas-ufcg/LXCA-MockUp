require 'securerandom'

FactoryGirl.define do
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

  factory :canister_properties, class: Hash do

    after :build do |canister_properties|
      canister_properties[:uri] = "/#{canister_properties[:uuid]}"
    end

    activationKeys []
    backedBy %w(real demo proxy).sample
    bladeState {Random.rand 17}
    cmmDisplayName { Faker::Hipster.word }
    cmmHealthState { health_states.sample }
    contact "No Contact Configured"
    dataHandle { Random.rand 2**61 }
    description { Faker::Hipster.sentence }
    domainName { Faker::Internet.domain_name }
    driveBays {Random.rand 100}
    drives []
    errorFields []

    firmware do
      (0..(Random.rand 10)).map do |number|
        {
          status: "",
          name: Faker::App.name,
          role: "",
          build: Faker::App.version,
          type: Faker::App.name,
          date: "",
          version: Faker::App.version
        }
      end
    end

    FRU { Faker::Lorem.characters(7).upcase }
    fruSerialNumber { Faker::Code.asin }
    hostname Faker::Internet.domain_name
    ipInterfaces { FactoryGirl.build :ip_interfaces_canister }

    ipv4Addresses []
    ipv4ServiceAddress ""
    ipv6Addresses []
    ipv6ServiceAddress ""
    lanOverUsb %w(anable disable).sample
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
    location []
    macAddress ""

    machineType "#{Random.rand 1000}"
    manufacturer {"#{Random.rand 100000}"} #Special attention
    manufacturerID {"#{Random.rand 100000}"} #Special attention
    memoryModules []
    memorySlots {Random.rand 10}
    model {"X#{Random.rand 99}"} #Special attention
    name { Faker::Internet.domain_name }
    parent []
    partNumber { SecureRandom.hex.upcase } #Special attention
    posID  {"#{Random.rand 100000}"}
    powerStatus [0, 5, 8, 18].sample
    processors do
      (0..(Random.rand 10)).map do |number|
        {
          speed: Faker::Number.decimal(3),
          family: "",
          manufacturer: "",
          slot: Random.rand(100),
          cores: led_colors.sample
        }
      end
    end

    processorSlots {Random.rand 10}
    productId { "#{Random.rand 1000}" }
    productName { Faker::App.name }
    posId { "#{Random.rand 1000}" }
    serviceHostName { Faker::Internet.domain_name }

    serialNumber { Faker::Code.ean }

    slots { Random.rand 100 }
    subType { SecureRandom.hex.upcase } #Special attention
    subSlots []
    userDescription { Faker::Hipster.sentence }
    uuid { SecureRandom.hex.upcase }
    vnicMode %w(anable disable).sample
    vpdID { "#{Random.rand 1000}" }

    initialize_with { attributes }
  end
end
