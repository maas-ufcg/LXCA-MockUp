Dir.glob('app/validators/chassi*.rb').each do |f|
  require_relative "../../#{f}"
end

class Chassi
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

  validates_with ChassiPropertiesValidators
  validates_with ChassiConscistencyValidator

end
