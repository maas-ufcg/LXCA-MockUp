# require_relative "../validators/power_supply_validators"

class PowerSupply
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

  after_create  :changeId, prepend: true

 # validates_with PowerSuppliesValidators

  private
    def changeId
      self._id = self.properties["uuid"]
    end

end
