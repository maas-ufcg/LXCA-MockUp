require "faker"

FactoryGirl.define do

  health_states = %(
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

led_states = %w(Off On Blinking Unknown)

power_states = %w(Off On ShuttingDown Standby Hibernate Unknown)

factory:power_supply_properties: Hash do
  cmmDisplayName {Faker::Hipster.word}
  cmmHealthState{health_states.sample}
  dataHandle{Random.rand 0...2**64}
  description{Faker::Company.catch_phrase}
  firmware do{
    "build" => Faker::App.version,
    "date" => Faker::Time.between(DateTime.now - 3650, DateTime.now).to_s.split.first,
    "name" => "#{Faker::App.name} firmware",
    "status" => "",
    "type" => "",
    "version" => Faker::App.version
  }end
  FRU ""
  fruSerialNumber ""
  hardwareRevision ""
  inputVoltageIsAC {[true,false].sample}
  inputVoltageMax {Random.rand -1...2**64}
  inputVoltageMin {Random.rand -1...2**64}
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
    machineType { Random.rand 0...2**64 }
    manufacturer ""
    manufactureDate { "#{Random.rand 0...10000}" }
    manufacturerID ""
    model ""
    name { Faker::Hipster.word }

    partNumber ""
    posID "" # Special Attention
    powerState { power_states.sample }

    productID "" # Special Attention
    productName { Faker::App.name }
    serialNumber { "US#{Random.rand 1000...100000}S"}
    slots 1 # Special attention
    type "PowerSupply"
    uri { Faker::Internet.url }
    userDescription { Faker::Lorem.sentence }
    uuid { SecureRandom.uuid }
    vpdID "" # Special attention

    initialize_with { attributes }

    end
end
