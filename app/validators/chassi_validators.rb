class ChassiValidators < ActiveModel::Validator
  def validate(record)
    if record == nil
      record.errors[:base] << "Record cannot be nil"
    end

      validate_access_state(record)
      validate_activation_keys(record)
      validate_active_alerts(record)
      ### Include the others methods
      validate_type(record, record.properties[:cmms], "Cmms", Array)
      validate_type(record, record.properties[:cmmSlots], "CmmSlots", Integer)
      validate_type(record, record.properties[:complex], "Complex", Array)
      validate_type(record, record.properties[:contact], "Contact", String)
      validate_type(record, record.properties[:dataHandle], "DataHandle", Fixnum)
      validate_type(record, record.properties[:description], "Description", String)
      validate_type(record, record.properties[:domainName], "DomainName", String)


      validate_security_policy(record)


      validate_location(record)

      validate_type(record, record.properties[:machineType], "MachineType", String)
      validate_type(record, record.properties[:managerName], "ManagerName", String)
      validate_type(record, record.properties[:managerUuid], "ManagerUuid", String)
      validate_type(record, record.properties[:manufacturer], "Manufacturer", String)
      validate_type(record, record.properties[:manufacturerID], "ManufacturerID", String)
      validate_type(record, record.properties[:mgmtProcIPaddress], "MgmtProcIPaddress", String)
      validate_type(record, record.properties[:model], "Model", String)
      validate_type(record, record.properties[:name], "Name", String)

      validate_nist(record)

      validate_type(record, record.properties[:nodes], "Nodes", Array)
      validate_type(record, record.properties[:partNumber], "PartNumber", String)
      validate_type(record, record.properties[:passThroughModules], "PassThroughModules", Array)
      validate_type(record, record.properties[:posID], "PosID", String)

      validate_power_allocation(record)

      validate_type(record, record.properties[:powerSupplySlots], "PowerSupplySlots", Integer)
      validate_type(record, record.properties[:powerSupplies], "PowerSupplies", Array)
      validate_type(record, record.properties[:productID], "ProductID", String)

      validate_type(record, record.properties[:overallHealthState], "OverallHealthState", String)
      validate_values(record, record.properties[:overallhealthState], "OverallHealthState",
                      %w(Normal Non-Critical Warning Minor-Failure Major-Failure Non-Recoverable Critical Unknown))

      validate_type(record, record.properties[:serialNumber], "SerialNumber", String)
      validate_status(record)
      validate_type(record, record.properties[:switches], "Switches", Array)
      validate_type(record, record.properties[:switchSlots], "SwitchSlots", Integer)
      validate_tls_version(record)
      validate_type(record, record.properties[:type], "Type", Chassis)
      validate_type(record, record.properties[:userDescription], "userDescription", String)
      validate_type(record, record.properties[:uuid], "Uuid", String)
      validate_type(record, record.properties[:vpdID], "VpdID", String)

  end

  private
  def validate_access_state(record)
    valid_values = %w(Online Offline Partial Pending Unknown)

    if not record.properties[:accessState].is_a? String
      record.errors[:base] << "AccessState attribute must be a String (actual: #{record.properties[:accessState].class})"
    elsif not valid_values.include? record.properties[:accessState]
      record.errors[:base] << "AccessState attribute is not valid"
    end
  end

    def validate_activation_keys(record)
      if not record.properties[:activationKeys].is_a? Array
        record.errors[:base] << "ActivationKeys attribute must be an Array (actual: #{record.properties[:activationKeys].class})"
      end
  end

    def validate_active_alerts(record)
      sub_keys = %i(corrIDs id location msg msgID severity)
      severity = %w(FATAL CRITICAL MAJOR MINOR WARNING INFORMATIONAL UNKNOWN)

      if not record.properties[:activeAlerts].is_a? Array
        record.errors[:base] << "ActiveAlerts attribute must be a Hash (actual: #{record.properties[:activeAlerts].class})"
      end

      record.properties[:activeAlerts].each do |alert|
        if not alert.is_a? Hash
          record.errors[:base] << "Alert attribute must be a Hash (actual: #{alert.class})"
        end

        sub_keys.each do |key|
          if alert[key] == nil
            record.errors[:base] << "ActiveAlerts hash must contain #{key} attribute"
          elsif not alert[key].is_a? String
            record.errors[:base] << "#{key.to_s} must be a String (actual: #{alert[key].class})"
          end
        end

        if not severity.include? alert[:severity]
          record.errors[:base] << "Severity attribute is not valid"
        end

      end
    end

    def validade_backed_by(record)
      backed_by_values = %w(real demo proxy)

      if not record.properties[:backedBy].is_a? String
        record.errors[:base] << "BackedBy attribute must be a String"
      elsif not backed_by_values.include? record.properties[:backedBy]
        record.errors[:base] << "BackedBy attribute is not valid"
      end
    end

    def validate_blade_slots(record)
      if not record.properties[:bladeSlots].is_a? Integer
        record.errors[:base] << "BladeSlots attribute must be an Integer"
      end
    end

    def validate_cmm_display_name(record)
      if not record.properties[:cmmDisplayName].is_a? String
        record.errors[:base] << "CmmDisplayName attribute must be a String"
      end
    end

    def validate_cmm_health_state(record)
      cmm_health_states = %w(
        Normal
        Non-Critical
        Warning
        Minor-Failure
        Major-Failure
        Non-Recoverable
        Critical
        Unknown
      )

      if not record.properties[:cmmHealthState].is_a? String
        record.errors[:base] << "CmmHealthState attribute must be a String"
      elsif not cmm_health_states.include? record.properties[:cmmHealthState]
        record.errors[:base] << "CmmHealthState attribute is not valid"
      end
    end

    def validate_encapsulation(record)
      encapsulation_mode = %w(
        notSupported
        normal
        encapsulationLite
      )

      if not record.properties[:encapsulation].is_a? Hash
        record.errors[:base] << "Encapsulation attribute must be a Hash (actual: #{record.properties[:encapsulation].class})"
      elsif record.properties[:encapsulation][:encapsulationMode] == nil
        record.errors[:base] << "Encapsulation hash must contain encapsulationMode attribute"
      elsif record.properties[:encapsulation][:nonBlockedIpAddressList] != nil and record.properties[:encapsulation][:encapsulationMode] != "encapsulationLite"
        record.errors[:base] << "nonBlockedIpAddressList field is available only when the encapsulation mode is encapsulationLite"
      elsif record.properties[:encapsulation][:nonBlockedIpAddressList] != nil and record.properties[:encapsulation][:encapsulationMode] == "encapsulationLite"
        if not record.properties[:encapsulation][:nonBlockedIpAddressList].is_a? Array
          record.errors[:base] << "NonBlockedIpAddressList attribute must be an Array (actual: #{record.properties[:encapsulation][:nonBlockedIpAddressList].class})"
        end
      elsif not encapsulation_mode.include? record.properties[:encapsulation][:encapsulationMode]
        record.errors[:base] << "EncapsulationMode attribute is not valid"
      end

    end

    def validate_energy_policies(record)
      accoustic_attenuation_mode_values = [
        "Off",
        "Least attenuation",
        "Low level attenuation",
        "Mid level attenuation",
        "High level attenuation",
        "Most attenuation",
        "Unknown"
      ]

      if not record.properties[:energyPolicies].is_a? Hash
        record.errors[:baseerrorFields] << "EnergyPolicies attribute must be a Hash (actual: #{record.properties[:energyPolicies].class})"
      elsif not record.properties[:energyPolicies][:accousticAttenuationMode].is_a? String
        record.errors[:base] << "AccousticAttenuationMode attribute must be a String (actual: #{record.properties[:energyPolicies][:accousticAttenuationMode].class})"
      elsif not accoustic_attenuation_mode_values.include? record.properties[:energyPolicies][:accousticAttenuationMode]
        record.errors[:base] << "AccousticAttenuationMode attribute is not valid"
      end

      validate_inner_hot_air_recirculation(record.properties[:energyPolicies][:hotAirRecirculation], record)
      validate_inner_power_capping_policy(record.properties[:powerCappingPolicy], record)

      if not record.properties[:energyPolicies][:powerRedundancyMode].is_a? Fixnum
        record.errors[:base] << "PowerRedundancyMode attribute must be a Fixnum (actual: #{record.properties[:energyPolicies][:powerRedundancyMode].class})"
      end

    end

    def validate_error_fields(record)
      valid_values = %w(FETCH_SUCCESS FETCH_FAILED NO_CONNECTOR FATAL_EXCEPTION NETWORK_FAIL)
      if not record.properties[:errorFields].is_a? Array
        record.errors[:base] << "ErrorFields attribute must be a Array (actual: #{record.properties[:errorFields].class})"
      elsif not valid_values.include? record.properties[:errorFields][:errorCode]
        record.errors[:base] << "ErrorFields is invalid. (Cause: errorCode)"
      end
    end

    def validate_excluded_health_state(record)
      valid_values = %W(Normal Non-Critical Warning Minor-Failure Major-Failure Non-Recoverable Critical Unknown)

      if not record.properties[:excludedHealthState].is_a? String
        record.errors[:base] << "ExcludedHealthState must be a String (actual: #{record.properties[:excludedHealthState].class})"
      end


    end

    def validate_location(record)
      validate_hash_keys(record, record.properties[:location], "Location", %i(location lowestRackUnit rack room))

      %i(location rack room).each do |key|
        validate_type(record, record.properties[key], key, String)
      end

      validate_type(record, record.properties[:lowestRackUnit], "LowestRackUnit", Integer)
    end

    def validate_nist(record)
      validate_type(record, record.properties[:nist], "Nist", Hash)

      validate_type(record, record.properties[:nist][:currentValue], "CurrentValue", String)
      validate_values(record, record.properties[:nist][:currentValue], "CurrentValue", %w(Unknown Compatibility Nist_800_131A_Strict Nist_800_131A_Custom))

      validate_type(record, record.properties[:nist][:possibleValues], "PossibleValues", Array)

    end

    def validate_power_allocation(record)
      valid_values = %w(Normal)
      sub_keys = %i(allocatedOutputPower midPlaneCardMaximumAllocatedPower midPlaneCardMinimumAllocatedPower remainingOutputPower totalInputPower totalOutputPower)

      validate_hash_keys(record, record.properties[:powerAllocation], "PowerAllocation", sub_keys)
      sub_keys.each do |key|
        verify_type(record, record.properties[:powerAllocation][key], "PowerAllocation", Fixnum)
      end



    end

    def validate_security_policy(record)
      sub_keys = %i(cmmPolicyLevel cmmPolicyState)
      cmm_policy_level_values = %w(LEGACY SECURE)
      cmm_policy_state_values = %w(ERROR UNKNOWN ACTIVE PENDING)

      validate_hash_keys(record, record.properties[:SecurityPolicy], "SecurityPolicy", sub_keys)
      validate_values(record, record.properties[:SecurityPolicy][:cmmPolicyLevel], "CmmPolicyLevel", cmm_policy_level_values)
      validate_values(record, record.properties[:SecurityPolicy][:cmmPolicyState], "CmmPolicyState", cmm_policy_state_values)

    end

    def validate_status(record)
      sub_keys = %(message name)

      validate_type(record, record.properties[:status], Hash)

      sub_keys.each do |key|
        if record.properties[:status][key] == nil
          record.errors[:base] << "Status attribute must contain #{key} attribute"
        elsif not record.properties[:status][key].is_a? String
          record.errors[:base] << "#{key} attribute must be a String (actual: #{record.properties[:status][key].class})"
        end
      end

    end

    def validate_tls_version(record)
      sub_keys = %i(currentValue possibleValues)
      valid_values = %w(Unknown SSL_30 TLS_10 TLS_11 TLS_12 TLS_12_Server_Client TLS_12_Server)

      if not record.properties[:tlsVersion].is_a? Hash
        record.errors[:base] << "TlsVersion attribute must be a Hash (actual: #{record.properties[:tlsVersion].class})"
      end

      sub_keys.each do |key|
        if record.properties[:tlsVersion][key] == nil
          record.errors[:base] << "TlsVersion attribute must contain #{key} attribute"
        end
      end

      if not record.properties[:tlsVersion][:currentValue].is_a? String
        record.errors[:base] << "CurrentValue attribute must be a String (actual: #{record.properties[:tlsVersion][:currentValue].class})"
      elsif not record.properties[:tlsVersion][:possibleValues].is_a? Array
        record.errors[:base] << "PossibleValues attribute must be a Array (actual: #{record.properties[:tlsVersion][:possibleValues].class})"
      end

    end

    # these methods should not be included in the main validate method body because they are already called in other methods
    def validate_inner_chassis_bay(chassis_bay, record)
         if not chassis_bay.is_a? Hash
           record.errors[:base] >> "ChassisBay attribute must be a Hash (actual: #{chassis_bay.class}"
         elsif not chassis_bay[:isExceeded].is_a? String
           record.errors[:base] << "IsExceeded attribute must be a String (actual: #{chassis_bay[:isExceeded].class})"
         elsif not chassis_bay[:sensorName].is_a? String
           record.errors[:base] << "SensorName attribute must be a String (actual: #{chassis_bay[:sensorName].class})"
         elsif not chassis_bay[:sensorValue].is_a? Float
           record.errors[:base] << "SensorValue attribute must be a Float (actual: #{chassis_bay[:sensorValue].class})"
         elsif not chassis_bay[:slot].is_a? Integer
           record.errors[:base] << "Slot attribute must be an Integer (actual: #{chassis_bay[:slot].class})"
         elsif not chassis_bay[:subSlot].is_a? Integer
           record.errors[:base] << "SubSlot attribute must be an Integer (actual: #{chassis_bay[:subSlot].class})"
         end

       end

    # this method should not be included in the main validate method body
    def validate_inner_hot_air_recirculation(hot_air_recirculation)
      validate_inner_chassis_bay(hot_air_recirculation[:chassisBay])

      isEnabled = [true, false]

      if not isEnabled.include? hot_air_recirculation[:isEnabled]
        record.errors[:base] << "IsEnabled attribute must be a boolean (actual: #{hot_air_recirculation[:isEnabled].class})"
      elsif not hot_air_recirculation[:maxVariation].is_a? Float
        record.errors[:base] << "MaxVariation attribute must be a Float (actual: #{hot_air_recirculation[:maxVariation].class})"
      end
    end

    def validate_inner_power_capping_policy(power_capping_policy, record)
      capping_policy_values = %w(OFF STATIC UNKNOWN)

      if not power_capping_policy.is_a? Hash
        record.errors[:base] >> "PowerCappingPolicy attribute must be a Hash (actual: #{power_capping_policy.class}"
      elsif not power_capping_policy[:cappingPolicy].is_a? String
        record.errors[:base] >> "CappingPolicy attribute must be a String (actual: #{power_capping_policy[:cappingPolicy].class}"
      elsif not capping_policy_values.include? power_capping_policy[:cappingPolicy]
        record.errors[:base] >> "CappingPolicy attribute is not valid"
      elsif not power_capping_policy[:currentPowerCap].is_a? Fixnum
        record.errors[:base] >> "CurrentPowerCap attribute must be a Fixnum (actual: #{power_capping_policy[:currentPowerCap].class}"
      elsif not power_capping_policy[:minPowerCap].is_a? Fixnum
        record.errors[:base] >> "MinPowerCap attribute must be a Fixnum (actual: #{power_capping_policy[:minPowerCap].class}"
      end
    end



    def validate_type(record, object, attribute_name, type_expected)
      if not object.is_a? type_expected
        record.errors[:base] << "#{attribute_name} attribute must be a/an #{type_expected} (actual: #{object.class})"
      end
    end


    def validate_values(record, object, attribute_name, valid_values)
      if not valid_values.include? object
        record.errors[:base] << "#{attribute_name} attribute is not valid"
      end
    end

    # this method verifies whether the given object is a hash and verifies if it contains the expected keys
    def validate_hash_keys(record, hash, attribute_name, expected_keys)
      validate_type(record, hash, attribute_name, Hash)

      expected_keys.each do |key|
        if hash[key] == nil
          record.errors[:base] << "#{attribute_name} attribute must contain the key #{key}"
        end
      end

    end
end