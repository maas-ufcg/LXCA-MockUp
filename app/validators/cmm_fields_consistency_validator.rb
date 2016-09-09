class CmmFieldsConsistencyValidator < ActiveModel::Validator

  def validate(record)
     if record.nil?
       record.errors[:base] << "The object cannot be nil."
     elsif not record.properties.is_a? Hash
       record.errors[:base] << "Properties attribute must be a Hash (actual: #{record.properties.class})"
     elsif record._id != record.properties[:uuid]
       record.errors[:base] << "Object _id must be equal to properties[:uuid]
       (actual _id: #{record._id} and uuid: #{record.properties[:uuid]})"
     end
   end
 end
