require_relative "../validators/switch_validators"

class Switch
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

  #before_create  :changeId, prepend: true

  def initialize(params={})
    super params

    # self._id = self.properties[:uuid]
 
  end

  validates_with SwitchValidators
end
