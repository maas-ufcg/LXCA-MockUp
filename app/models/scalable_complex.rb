require_relative "../validators/scalable_complex_validators"

class ScalableComplex
  include Mongoid::Document
  field :_id, type: String #complexID
  field :properties, type: Hash

  def initialize(params = {})
    super params
  end

  validates_with ScalableComplexValidators

end
