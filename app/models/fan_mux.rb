#Dir.glob('app/validators/fan*.rb').each do |f|
#  require_relative "../../#{f}"
#end

require 'fan_muxes_consistency_validator'
require 'fan_muxes_required_properties_validator'

class FanMux
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash
  
  validates_with FanMuxRequiredPropertiesValidator
  validates_with FanMuxConsistencyValidator
end
