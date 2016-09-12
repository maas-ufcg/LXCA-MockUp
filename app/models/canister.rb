Dir.glob('app/validators/canister*.rb').each do |c|
  require_relative "../../#{c}"
end


class Canister
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

  validates_with CanisterRequiredPropertiesValidator
  validates_with CanisterConsistencyValidator
end
