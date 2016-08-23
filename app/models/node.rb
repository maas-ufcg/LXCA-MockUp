require_relative '../validators/access_state_validator'

class Node
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

  validates_with AccessStateValidator
end
