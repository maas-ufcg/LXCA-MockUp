require_relative "../validators/power_supply_validators"

class PowerSupply
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

  validates_with PowerSuppliesValidators
end
