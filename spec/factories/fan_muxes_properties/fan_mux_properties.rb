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

  factory :fan_mux_properties, class: Hash do

    after :build do |fan_mux_properties|
      fan_mux_properties[:uri] = "fanMuxes/#{fan_mux_properties[:uuid]}"
    end

    cmmDisplayName { Faker::Hipster.word }
    cmmHealthState { health_states.sample }
    dataHandle { Random.rand 2**61 }
    description { Faker::Hipster.sentence }
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
    manufacturer { Faker::Company.name }
    manufacturingDate { "#{Random.rand 10000}" }
    manufacturerID { Faker::Company.ein }
    model ""
    name { "FanMux #{Random.rand 2**32}" }
    parent do
      {
        uri: Faker::Internet.url,
        uuid: SecureRandom.hex.upcase
      }
    end
    partNumber { Faker::Code.asin }
    productID { "#{Random.rand 1000}" }
    productName { Faker::App.name }
    serialNumber { Faker::Code.ean }
    slots { Random.rand 100 } # Special attention
    status { health_states.sample }
    type "FanMux"
    uuid { SecureRandom.hex.upcase }

    initialize_with { attributes }
  end
end
