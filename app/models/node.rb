require_relative "../validators/access_state_validator"
require_relative "../validators/key_identifier_type_validator"

class Node
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

  validates_with AccessStateValidator
  validates_with KeyIdentifierTypeValidator
end
