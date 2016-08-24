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

  error_codes = %w(
    FETCH_SUCCESS
    FETCH_FAILED
    NO_CONNECTOR
    FATAL_EXCEPTION
    NETWORK_FAIL
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

  factory :fan_properties, class: Hash do

    after :build do |fan_properties|
      fan_properties[:uri] = "fans/#{fan_properties[:uuid]}"
    end

    cmmDisplayName { Faker::Hipster.word }
    cmmHealthState { health_states.sample }
    dataHandle { Random.rand 2**61 }
    description { Faker::Hipster.sentence }
    errorFields []
    firmware do
      (0..(Random.rand 10)).map do |number|
        {
          build: Faker::App.version,
          date: "",
          name: Faker::App.name,
          role: "",
          status: "",
          type: Faker::App.name,
          version: Faker::App.version
        }
      end
    end
    FRU { Faker::Lorem.characters(7).upcase }
    fruSerialNumber { Faker::Code.asin }
    hardwareRevision { Faker::App.version }
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
    machineType ""
    manufacturingDate { "#{Random.rand 10000}" }
    manufacturer { Faker::Company.name }
    manufacturerID { Faker::Company.ein }
    model ""
    name { "Fan #{Random.rand 2**32}" }
    parent do
      {
        uri: Faker::Internet.url,
        uuid: SecureRandom.hex.upcase
      }
    end
    partNumber { Faker::Code.asin }
    posID { "#{Random.rand 1000}" }
    powerAllocation do
      power = Random.rand 2**61
      {
        maximumAllocatedPower: power,
        minimumAllocatedPower: power/2
      }
    end
    powerState { power_states.sample }
    productID { "#{Random.rand 1000}" }
    productName { Faker::App.name }
    serialNumber { Faker::Code.ean }
    slots { Random.rand 100 } # Special attention
    type "Fan"
    uuid { SecureRandom.hex.upcase }
    userDescription { Faker::Hipster.sentence }
    vpdID { "#{Random.rand 1000}" }

    initialize_with { attributes }
  end
end
