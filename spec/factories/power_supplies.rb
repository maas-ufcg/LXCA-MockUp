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

end



end
