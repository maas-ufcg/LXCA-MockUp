require_relative '../validators/cmm_fields_consistency_validator'


class Cmm
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

  validates_with CmmFieldsConsistencyValidator
  validates_with CmmPropertiesValidator
end
