require_relative '../validators/node_fields_consistency_validator'

class Node
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

 validates_with NodeFieldsConsistencyValidator
end
