class PowerSupplyConsistencyValidator < ActiveModel::Validator

  def validate(record)
    if record.nil?
      record.errors[:base] << "The object can't be null"
    elsif record.properties.nil?
      record.errors[:base] << "properties attirbute can't be nil"
    elsif not record.properties.is_a?(Hash)
      record.errors[:base] << "properties must be a Hash"
    elsif record._id != record.properties[:uuid]
      record.errors[:base] << "Object _id must be equal to properties[:_id]"
    end
  end
end
