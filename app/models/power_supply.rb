require_relative "../validators/power_supply_validators"
require_relative "../validators/power_supply_consistency_validator"

class PowerSupply
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

 validates_with PowerSuppliesValidators
 validates_with PowerSupplyConsistencyValidator
end
