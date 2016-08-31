class NodeFieldsConsistencyValidator < ActiveModel::Validator

  def validate(record)
    validate_properties(record)
    validate_id_and_uuid(record)
    validate_fields_presence(record)
    validate_fields_value(record)
  end

  private

  def validate_properties(record_v)
    if record_v.nil?
      record_v.error[:base] << "The object should not be nill"
    elsif record_v.properties.nil?
      record_v.error[:base] << "properties attribute should not be nil"
    elsif not record_v.properties.is_a? Hash
      record_v.error[:base] << "properties must be a Hash"
    end
  end

  def validate_id_and_uuid(record_v)
    if record_v.nil?
      record_v.errors[:base] << "The UUID attribute should not be nill"
    elsif record_v._id != record_v.properties[:uuid]
      record_v.errors[:base] << "Object _id must be equal to properties[:_id]"
    elsif record_v.properties[:uuid].nil? or record_v.properties[:uuid] == ""
      record_v.errors[:base] << "The UUID atribute should neither be nil nor empty"
      endvalidate_isAddOnCard
    end
  end

  def validate_fields_presence(record_v)
    NodesHelper::required_fields.each do |field|
      if not record_v.properties.has_key? field
        record_v.errors[:base] << "missing #{field} property object"
      elsif record_v.properties[field].nil?
        record_v.errors[:base] << "field #{field} can't be nil"
      elsif record_v.properties[field] == ""
        record_v.errors[:base] << "field #{field} can't be an empty string"
      end
    end
  end

  def validate_fields_value(record_v)
    values_per_field = NodesHelper::possible_values_per_field
    values_per_field.keys.take(10).each do |field|
      if not values_per_field[field].include? record_v.properties[field]
        record_v.errors[:base] << "field #{field} can't have value #{record_v.properties[field]})"
      end
    end
  end
end
