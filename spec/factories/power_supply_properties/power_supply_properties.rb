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
  Unknown)
  led_colors = %w(Red Amber Yellow Green Blue Unknown)

  led_locations = [
    "Front panel",
    "Lightpath Card",
    "Planar",
    "FRU",
    "Rear Panel",
    "Unknown"
  ]

  uuids_values_parent = SecureRandom.hex.upcase
  uuids_values = SecureRandom.hex.upcase
  partNumber_value = SecureRandom.hex.upcase

  led_states = %w(Off On Blinking Unknown)

  power_states = %w(Off On ShuttingDown Standby Hibernate Unknown)

  factory :power_supply_properties, class: Hash do
    cmmDisplayName { Faker::Hipster.word }
    cmmHealthState { health_states.sample }
    dataHandle { Random.rand 0...2**61 }
    description { Faker::Company.catch_phrase }
    firmware do
      [{
        :build => Faker::App.version,
        :date => Faker::Time.between(DateTime.now - 3650, DateTime.now).to_s.split.first,
        :name => "#{Faker::App.name} firmware",
        :status => "",
        :type => "",
        :version => Faker::App.version
        }]
      end
      FRU { partNumber_value }
      fruSerialNumber SecureRandom.hex(10).upcase
      hardwareRevision (10 * SecureRandom.random_number).round(1)
      inputVoltageIsAC {[true,false].sample}
      inputVoltageMax {Random.rand -1...2**61}
      inputVoltageMin {Random.rand -1...2**61}
      leds do
        (0..5).map do |number|
          {
            :color => led_colors.sample,
            :location => led_locations.sample,
            :name => Faker::Lorem.word,
            :state => led_states.sample
          }
        end
      end
      machineType ""
      manufacturer "IBM"
      manufactureDate { Faker::Number.number(4).to_s }
      manufacturerID { "#{Random.rand 0...10000}" }
      model ""
      name { Faker::Hipster.word }
      parent do
        {
          :uri =>  "chassis/" + uuids_values_parent,
          :uuid =>  uuids_values_parent
        }
      end
      powerAllocation do
        {
          :totalInputPower => Random.rand(0...2**61),
          :totalOutputPower => Random.rand(0...2**61)
        }
      end
      partNumber { partNumber_value }
      posID { "#{Random.rand 1...1000}" }
      powerState { power_states.sample }

      productID { "#{Random.rand 1...1000}" }
      productName { Faker::App.name }
      serialNumber { "US#{Random.rand 1000...100000}S" }
      slots 1 # Special attention
      type "PowerSupply"
      uri { Faker::Internet.slug("chassis #{uuids_values}", '/') }
      userDescription { Faker::Lorem.sentence }
      uuid { uuids_values }
      vpdID { "#{Random.rand 1...1000}" }

      initialize_with { attributes }
    end
  end
