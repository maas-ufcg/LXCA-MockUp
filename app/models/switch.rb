require_relative "../validators/switch_validators"

class Switch
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

  after_create  :changeId, prepend: true

 validates_with SwitchValidators

  private
    def changeId
      self._id = self.properties["uuid"]
    end


end
