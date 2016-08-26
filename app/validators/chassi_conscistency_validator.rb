class ChassiConscistencyValidator < ActiveModel::Validator

  def validate(record)
    if record.nil?
      record.errors[:base] << "The object can't be null"
    #The method ".is_a?" verify if the properties object is nil and a Hash.
    elsif not record.properties.is_a? Hash
      record.errors[:base] << "properties must be a Hash (actual: #{record.properties.class})"
    elsif record._id != record.properties[:uuid]
      record.errors[:base] << "Object _id must be equal to properties[:uuid]
      (actual _id: #{record._id} and uuid: #{record.properties[:uuid]})"
    end
  end
end
