class CmmPropertiesValidator < ActiveModel::Validator

  def validate(record)
    if record.nil?
      record.errors[:base] << "Record cannot be nil"
    end

    @record = record
    @valid_values = CmmsHelper::possible_values_per_field

    validate_type(:accessState, String)
    validate_values(:accessState, @valid_values[:accessState])

    validate_type(:backedBy, String)
    validate_values(:backedBy, @valid_values[:backedBy])

    validate_type(:cmmDisplayName, String)

    validate_type(:cmmHealthState, String)
    validate_values(:cmmHealthState, @valid_values[:cmmHealthState])

    validate_type(:dataHandle, String)
    validate_type(:description, String)
    validate_type(:dnsHostNames, Array)
    validate_type(:domainName, String)

    validate_type(:errorFields, Array)

    validate_type(:excludedHealthState, String)
    validate_values(:excludedHealthState, @valid_values[:excludedHealthState])

    validate_type(:firmware, Array)
    validate_type(:FRU, String)
    validate_type(:fruSerialNumber, String)
    validate_type(:hostConfig, Array)

    validate_type(:hostname, String)
    validate_type(:ipInterfaces, Array)

    validate_type(:ipv4Addresses, Array)
    validate_type(:ipv6Addresses, Array)
    validate_type(:leds, Array)
    validate_type(:macAddresses, Array)
    validate_type(:machineType, String)
    validate_type(:mgmtProcIPaddress, String)
    validate_type(:model, String)

    validate_type(:name, String)
    validate_values(:name, @valid_values[:name])

    validate_type(:overallHealthState, String)
    validate_type(:parent, Hash)
    validate_type(:partNumber, String)
    validate_type(:powerAllocation, Hash)
    validate_type(:productID, String)

    validate_type(:role, String)
    validate_values(:role, @valid_values[:role])

    validate_type(:serialNumber, String)
    validate_type(:slots, String)
    validate_type(:type, String)
    validate_type(:userDescription, String)
    validate_type(:uri, String)
    validate_type(:uuid, String)

  end

  private

  def validate_type(attribute_key, type)
    if not @record.properties[attribute_key].is_a? type
      @record.errors[:base] << "#{attribute_key} attribute should be a/an #{type} (actual:#{@record.properties[attribute_key].class})"
    end
  end

  def validate_values(attribute_key, possible_values)
    if not possible_values.include? @record.properties[attribute_key]
      @record.errors[:base] << "#{attribute_key} attribute is not valid"
    end
  end

end
