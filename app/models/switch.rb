require "../validators/switch_validators"

class Switch
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

  validates_with SwitchValidators  
end
