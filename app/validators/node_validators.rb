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
    #isAgentless(record)
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

  #Verificar para caso o isAgentless ser falso, e algum atributo do inventário deve ser vazio
  def validate_isAgentless(record_v)
    validValues = [true, false]

    if not validValues.include? record_v.properties[:isAgentless]
      record_v.errors[:base] << "isAgentless attribute is not valid"
    end
  end

  def validate_portType(record_v)
    validValues = ["ATM","ETHERNET", "FC", "FDDI", "FRAMERELAY", "IB", "OTHER", "TOKENRING", "UNKNOWN"]

    if not validValues.include? record_v.properties[:portType].to_s
      record_v.errors[:base] << "portType attribute is not valid"
    end
  end

  def validate_vnicMode(record_v)
    validValues = [true, false]

    if not validValues.include? record_v.properties[:vnicMode]
      record_v.errors[:base] << "vnicMode attribute is not valid"
    end
  end

  def validate_slotSupportsHotPlug(record_v)
    validValues = [true, false]

    if not validValues.include? record_v.properties[:slotSupportsHotPlug]
      record_v.errors[:base] << "slotSupportsHotPlug attribute is not valid"
    end
  end

  def validate_arch(record_v)
    validValues = ["ia64", "ppc", "ppc64", "x86", "x86_64", "Unknown"]

    if not validValues.include? record_v.properties[:arch]
      record_v.errors[:base] << "arch attribute is not valid"
    end
  end

  def validate_backedBy(record_v)
    validValues = ["real", "demo", "proxy"]

    if not validValues.include? record_v.properties[:backedBy]
      record_v.errors[:base] << "backedBy attribute is not valid"
    end
  end

  def validate_bladeState(record_v)
    validValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]

    if not validValues.include? record_v.properties[:bladeState]
      record_v.errors[:base] << "bladeState attribute is not valid"
    end
  end

  def validate_bootType(record_v)
    validValues = ["Permanent", "SingleUse", "WakeOnLan", "Unknown"]

    if not validValues.include? record_v.properties[:bootType]
      record_v.errors[:base] << "bootType attribute is not valid"
    end
  end

  def validate_cmmHealthState(record_v)
    validValues = ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown", "Informational", "Minor", "Major", "Critical", "Fatal"]

    if not validValues.include? record_v.properties[:cmmHealthState]
      record_v.errors[:base] << "cmmHealthState attribute is not valid"
    end
  end

  def validate_raidPresence(record_v)
    validValues = ["Regular", "Non-RAID drive"]

    if not validValues.include? record_v.properties[:raidPresence]
      record_v.errors[:base] << "raidPresence attribute is not valid"
    end
  end

  def validate_state(record_v)
    validValues = ["active", "stopped", "transitioning"]

    if not validValues.include? record_v.properties[:state]
      record_v.errors[:base] << "state attribute is not valid"
    end
  end

  def validate_embeddedHypervisorPresence(record_v)
    validValues = [true, false]

    if not validValues.include? record_v.properties[:embeddedHypervisorPresence]
      record_v.errors[:base] << "embeddedHypervisorPresence attribute is not valid"
    end
  end

  def validate_encapsulationMode(record_v)
    validValues = ["notSupported", "normal", "encapsulationLite"]

    if not validValues.include? record_v.properties[:encapsulationMode]
      record_v.errors[:base] << "encapsulationMode attribute is not valid"
    end
  end

  def validate_errorFields(record_v)
    validValues = ["FETCH_SUCCESS", "FETCH_FAILED", "NO_CONNECTOR", "FATAL_EXCEPTION", "NETWORK_FAIL"]

    if not validValues.include? record_v.properties[:errorFields]
      record_v.errors[:base] << "errorFields attribute is not valid"
    end
  end

  def validate_excludedHealthState(record_v)
    validValues = ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"]

    if not validValues.include? record_v.properties[:excludedHealthState]
      record_v.errors[:base] << "excludedHealthState attribute is not valid"
    end
  end

  def validate_vnicMode(record_v)
    validValues = [true, false]

    if not validValues.include? record_v.properties[:vnicMode]
      record_v.errors[:base] << "vnicMode attribute is not valid"
    end
  end

  def validate_expansionProductType(record_v)
    validValues = ["SEN", "PEN", "Expansion card", "Addin Card", "PCI Express Card", "Unknown"]

    if not validValues.include? record_v.properties[:expansionProductType]
      record_v.errors[:base] << "expansionProductType attribute is not valid"
    end
  end

  def validate_expansionProducts(record_v)
    validValues = ["expansionProducts", "expansionCards", "addinCards", "pciExpressCards"]

    if not validValues.include? record_v.properties[:expansionProductType]
      record_v.errors[:base] << "expansionProductType attribute is not valid"
    end
  end

  def validate_hasOS(record_v)
    validValues = [true, false]

    if not validValues.include? record_v.properties[:hasOS]
      record_v.errors[:base] << "hasOS attribute is not valid"
    end
  end

  def validate_IPv4DHCPmode(record_v)
    validValues = ["STATIC_ONLY", "DHCP_ONLY", "DHCP_THEN_STATIC", "UNKNOWN"]

    if not validValues.include? record_v.properties[:IPv4DHCPmode]
      record_v.errors[:base] << "IPv4DHCPmode attribute is not valid"
    end
  end

  def validate_IPv4enabled(record_v)
    validValues = [true, false]

    if not validValues.include? record_v.properties[:IPv4enabled]
      record_v.errors[:base] << "IPv4enabled attribute is not valid"
    end
  end

  def validate_IPv6enabled(record_v)
    validValues = [true, false]

    if not validValues.include? record_v.properties[:IPv6enabled]
      record_v.errors[:base] << "IPv6enabled attribute is not valid"
    end
  end

  def validate_isConnectionTrusted(record_v)
    validValues = [true, false]

    if not validValues.include? record_v.properties[:isConnectionTrusted]
      record_v.errors[:base] << "isConnectionTrusted attribute is not valid"
    end
  end

  def validate_isRemotePresenceEnabled(record_v)
    validValues = [true, false]

    if not validValues.include? record_v.properties[:isRemotePresenceEnabled]
      record_v.errors[:base] << "isRemotePresenceEnabled attribute is not valid"
    end
  end

  def validate_isScalable(record_v)
    validValues = [true, false]

    if not validValues.include? record_v.properties[:isScalable]
      record_v.errors[:base] << "isScalable attribute is not valid"
    end
  end

  def validate_lanOverUsb(record_v)
    validValues = ["enabled", "disabled"]

    if not validValues.include? record_v.properties[:lanOverUsb]
      record_v.errors[:base] << "lanOverUsb attribute is not valid"
    end
  end

  def validate_currentValue(record_v)
    validValues = ["Unknown", "Compatibility", "Nist_800_131A_Strict", "Nist_800_131A_Custom"]

    if not validValues.include? record_v.properties[:currentValue]
      record_v.errors[:base] << "currentValue attribute is not valid"
    end
  end

  def validate_overallHealthState(record_v)
    validValues = ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"]

    if not validValues.include? record_v.properties[:overallHealthState]
      record_v.errors[:base] << "overallHealthState attribute is not valid"
    end
  end

  def validate_partitionEnabled(record_v)
    validValues = [true, false]

    if not validValues.include? record_v.properties[:partitionEnabled]
      record_v.errors[:base] << "partitionEnabled attribute is not valid"
    end
  end

  def validate_cappingACorDCMode(record_v)
    validValues = ["AC", "DC", "Unknown"]

    if not validValues.include? record_v.properties[:cappingACorDCMode]
      record_v.errors[:base] << "cappingACorDCMode attribute is not valid"
    end
  end

  def validate_cappingPolicy(record_v)
    validValues = ["OFF", "STATIC", "UNKNOWN"]

    if not validValues.include? record_v.properties[:cappingPolicy]
      record_v.errors[:base] << "cappingPolicy attribute is not valid"
    end
  end

  def validate_powerStatus(record_v)
    validValues = [0, 5, 8, 18]

    if not validValues.include? record_v.properties[:powerStatus]
      record_v.errors[:base] << "powerStatus attribute is not valid"
    end
  end
end
