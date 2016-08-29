class AccessStateValidator < ActiveModel::Validator

  def validate(record)
    validate_properties(record)
    validate_id_and_uuid(record)
    validate_fields(record)
    validate_accessState(record)
    validate_keyIdentifierType(record)
    validate_keyStatus(record)
    validate_role(record)
    validate_isAddOnCard(record)
    isAgentless(record)
  end

private

def validate_properties(record_v)
    if record_v.nil?
      record_v.error[:base] << "The object should not be nill"
    elsif record_v.properties.nil?
      record_v.error[:base] << "properties attribute should not be nil"
    elsif not record_v.properties.is_a?(:Hash)
      record_v.error[:base] << "properties must be a Hash"
end

def validate_id_and_uuid(record_v)
  if record_v.nil?
    record_v.error[:base] << "The UUID attribute should not be nill"
  elsif record_v._id != record.properties[:uuid]
    record_v.error[:base] << "Object _id must be equal to properties[:_id]"
  elsif record_v.properties[:uuid].nil? or record_v.properties[:uuid] == ""
    record_v.error[:base] << "The UUID atribute should neither be nil nor empty"
  endvalidate_isAddOnCard
end

def validate_fields(record_v)
  NodesHelper::required_fields.each do |field|
      if record_v.properties[field].nil?
          record_v.error[:base] << "missing properties object"
        break
      end
    end
  end

def validate_accessState(record_v)
  validValues = ["Online", "Offline", "Partial", "Pending", "Unknown"]

    if not validValues.include? record_v.properties[:accessState].to_s
      record_v.errors[:base] << "AccessState attribute is not valid"
    end
  end

def validate_keyIdentifierType(record_v)
  validValues = ["ASIC", "MAC", "MT", "UNKNOWN"]

  if not validValues.include? record_v.properties[:keyIdentifierType].to_s
    record_v.errors[:base] << "keyIdentifierType attribute is not valid"
  end
end

def validate_keyStatus(recor_v)
  validValues = ["UNKNOWN", "OTHER", "VALID", "INVALID", "INPROCESS", "EXPIRED", "LIMIT_REACHED", "NEED_VALID_ELSEWHERE", "KEY_NOT_FOUND"]

  if not validValues.include? record_v.properties[:keyStatus].to_s
    record_v.errors[:base] << "keyStatus attribute is not valid"
  end
end

def validate_role(record_v)
  validValues = ["Primary", "Backup", "Temporary", "Permanent"]

  if not validValues.include? record_v.properties[:role].to_s
    record_v.errors[:base] << "role attribute is not valid"
  end
end

def validate_isAddOnCard(record_v)
  validValues = [true, false]

  if not validValues.include? record_v.properties[:isAddOnCard]
    record_v.errors[:base] << "isAddOnCard attribute is not valid"
  end
end

def validate_isAgentless(record_v)
  validValues = [true, false]

  if not validValues.include? record_v.properties[:isAgentless]
    record_v.errors[:base] << "isAgentless attribute is not valid"
  end
end
