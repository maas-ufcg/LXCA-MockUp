class Chassi
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

  after_create :changeId, prepend: true

  validates_with ChassiPropertiesValidators
  validates_with ChassiConscistencyValidator

  private
   def changeId
     self._id = self.properties["uuid"]
   end

end
