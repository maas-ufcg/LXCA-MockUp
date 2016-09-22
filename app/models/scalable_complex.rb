require_relative "../validators/scalable_complex_validators"

class ScalableComplex
  include Mongoid::Document
  field :_id, type: String #complexID
  field :properties, type: Hash

  
  validates_with ScalableComplexValidators

end
