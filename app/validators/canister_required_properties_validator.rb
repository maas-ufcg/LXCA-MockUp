class CanisterRequiredPropertiesValidator < ActiveModel::Validator

  def validate(record)
    if record.nil?
      record.errors[:base] << "The object can't be null"
    elsif record.properties.nil?
      record.errors[:base] << "properties attirbute can't be nil"
    elsif not record.properties.is_a?(Hash)
      record.errors[:base] << "properties must be a Hash"
    else
      CanistersHelper::required_fields.each do |field|
        if not record.properties.has_key? field
          record.errors[:base] << "properties must have :#{field} key"
        elsif record.properties[field] == nil
          record.errors[:base] << "properties[:#{field}] can't be nil"
        end

        if record.properties[field] == ""
          record.errors[:base] << "properties[:#{field}] can't be empty string"
        end
      end
    end
  end
end
