require 'securerandom'

FactoryGirl.define do
  led_colors = %w(Red Amber Yellow Green Blue Unknown)

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

  factory :cannister_properties, class: Hash do

    after :build do |canister_properties|
      fan_properties[:uri] = "/#{canister_properties[:uuid]}"
    end

    backedBy %w(real demo proxy).sample
    cmmDisplayName { Faker::Hipster.word }
    cmmHealthState { health_states.sample } #Special attention
    contact "No Contact Configured"
    dataHandle { Random.rand 2**61 }
    description { Faker::Hipster.sentence }
    domainName ""
    driveBays {Random.rand 100} # Special attention
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

    fruSerialNumber {}
    fru {}

    ipInterfaces { FactoryGirl.build :ip_interfaces }



    machineType "#{Random.rand 1000}"
    manufacturer {}
    memoryModules {}
    memorySlots {}
    model {}
    name {}
    partNumber {}
    powerStatus [0, 5, 8, 18].sample
    processors do
      (0..(Random.rand 10)).map do |number|
        speed: Faker::Number.decimal(3),
        family: "",
        manufacturer: "",
        slot: Random.rand 100, # Special attention
        cores: led_colors.sample
      end
    end

    processorSlots {}
    productID { "#{Random.rand 1000}" }
    productName { Faker::App.name }
    posId {Random.rand 1000} # Special attention
    serviceHostName ""
    slots { Random.rand 100 } # Special attention
    subType []
    subSlots []
    userDescription { Faker::Hipster.sentence }
    uuid { SecureRandom.hex.upcase }
    vnicMode [anable, disable].sample
    vpdID { "#{Random.rand 1000}" }
  end
end
