require_relative '../validators/node_validators'

class Node
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

 validates_with AccessStateValidator
end
