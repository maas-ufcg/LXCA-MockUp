require_relative "../validators/scalable_complex_validators"

class ScalableComplex < ApplicationRecord
  include Mongoid::Document
  field :_id, type: String #complexID
  field :properties, type: Hash

  def initialize(params = {})
    super params
  end

  #TODO build validators for scalable complex models
  validates_with ScalableComplexValidators

end
