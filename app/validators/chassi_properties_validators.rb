class ChassiPropertiesValidators < ActiveModel::Validator
  def validate(record)
    if record.nil?
      record.errors[:base] << "Record cannot be nil"
    end

      validate_access_state(record)

      validate_type(record, record.properties[:activeAlerts], "activeAlerts", Array)

      validate_type(record, record.properties[:activationKeys], "activationKeys", Array)


      validate_active_alerts(record)

      validate_type(record, record.properties[:backedBy], "BackedBy", String)
      validate_values(record, record.properties[:backedBy], "BackedBy", %w(real demo proxy))

      validate_type(record, record.properties[:bladeSlots], "BladeSlots", Integer)
      validate_type(record, record.properties[:cmmDisplayName], "CmmDisplayName", String)

      validate_type(record, record.properties[:cmmHealthState], "cmmHealthState", String)
      validate_values(record, record.properties[:cmmHealthState], "cmmHealthState",
        %w(Normal Non-Critical Warning Minor-Failure Major-Failure Non-Recoverable Critical Unknown))

      validate_type(record, record.properties[:ledCardSlots], "ledCardSlots", Integer)

      validate_type(record, record.properties[:cmms], "Cmms", Array)
      validate_type(record, record.properties[:cmmSlots], "CmmSlots", Integer)
      validate_type(record, record.properties[:complex], "Complex", Array)
      validate_type(record, record.properties[:contact], "Contact", String)
      validate_type(record, record.properties[:dataHandle], "DataHandle", Fixnum)
      validate_type(record, record.properties[:description], "Description", String)
      validate_type(record, record.properties[:domainName], "DomainName", String)

      validate_encapsulation(record)
      validate_energy_policies(record)

      validate_type(record, record.properties[:errorFields], "ErrorFields", Array)
      if record.properties[:errorFields].is_a? Array
        validate_type(record, record.properties[:errorFields][0][:string], "ErrorFields", String)
        validate_type(record, record.properties[:errorFields][0][:errorCode], "ErrorCode", String)
        validate_values(record, record.properties[:errorFields][0][:errorCode], "ErrorCode", %w(FETCH_SUCCESS FETCH_FAILED NO_CONNECTOR FATAL_EXCEPTION NETWORK_FAIL))
      end

      validate_type(record, record.properties[:excludedHealthState], "ExcludedHealthState", String)
      validate_values(record, record.properties[:excludedHealthState], "ExcludedHealthState", %w(Normal Non-Critical Warning Minor-Failure Major-Failure Non-Recoverable Critical Unknown))

      validate_type(record, record.properties[:fanMuxes], "FanMuxes", Array)
      validate_type(record, record.properties[:fanMuxSlots], "FanMuxSlots", Integer)
      validate_type(record, record.properties[:fans], "Fans", Array)
      validate_type(record, record.properties[:fanSlots], "FanSlots", Integer)
      validate_type(record, record.properties[:height], "Height", Integer)
      validate_type(record, record.properties[:hostname], "Hostname", String)

      validate_is_connection_trusted(record)

      validate_type(record, record.properties[:ledCardSlots], "ledCardSlots", Integer)

      validate_leds(record)
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



      validate_values(record, record.properties[:overallHealthState], "OverallHealthState",
                      %w(Normal Non-Critical Warning Minor-Failure Major-Failure Non-Recoverable Critical Unknown))

      validate_security_policy(record)

      validate_type(record, record.properties[:serialNumber], "SerialNumber", String)

      validate_status(record)

      validate_type(record, record.properties[:switches], "Switches", Array)
      validate_type(record, record.properties[:switchSlots], "SwitchSlots", Integer)

      validate_tls_version(record)

      validate_type(record, record.properties[:type], "Type", String)
      validate_type(record, record.properties[:userDescription], "userDescription", String)
      validate_type(record, record.properties[:uri], "uri", String)
      validate_type(record, record.properties[:uuid], "Uuid", String)
      validate_type(record, record.properties[:vpdID], "VpdID", String)

  end

  private
    def validate_access_state(record)
      valid_values = %w(Online Offline Partial Pending Unknown)

      validate_type(record, record.properties[:accessState], "accessState", String)
      validate_values(record, record.properties[:accessState], "accessState", valid_values)

    end

    def validate_active_alerts(record)

      sub_keys = %i(corrIDs id location msg msgID severity)
      severity = %w(FATAL CRITICAL MAJOR MINOR WARNING INFORMATIONAL UNKNOWN)

      validate_type(record, record.properties[:activeAlerts], "activeAlerts", Array)

      if record.properties[:activeAlerts].is_a? Array
        record.properties[:activeAlerts].each do |alert|
          validate_type(record, alert, "Alert", Hash)

          # not working
          # validate_hash_keys(record, alert, "Alert", sub_keys)

          validate_values(record, alert[:severity], "Severity", severity)
        end
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
      elsif record.properties[:encapsulation][:encapsulationMode].nil?
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

      validate_type(record, record.properties[:energyPolicies], "EnergyPolicies", Hash)
      if record.properties[:energyPolicies].is_a? Hash
        validate_type(record, record.properties[:energyPolicies][:accousticAttenuationMode], "AccousticAttenuationMode", String)
        validate_values(record, record.properties[:energyPolicies][:accousticAttenuationMode], "AccousticAttenuationMode", accoustic_attenuation_mode_values)

        validate_inner_hot_air_recirculation(record.properties[:energyPolicies][:hotAirRecirculation], record)
        validate_inner_power_capping_policy(record.properties[:energyPolicies][:powerCappingPolicy], record)

        validate_type(record, record.properties[:energyPolicies][:powerRedundancyMode], "powerRedundancyMode", Fixnum)
      end
    end

    def validate_is_connection_trusted(record)
      values = [true, false]

      if record.properties[:isConnectionTrusted].nil?
        record.errors[:base] << "isConnectionTrusted attribute cannot be nil"
      elsif not values.include? record.properties[:isConnectionTrusted]
        record.errors[:base] << "isConnectionTrusted attribute is invalid"
      end

    end

    def validate_leds(record)
      sub_keys = %i(color location name state)
      validate_type(record, record.properties[:leds], "leds", Array)

      if record.properties[:leds].is_a? Array

        validate_hash_keys(record, record.properties[:leds][0], "Leds", sub_keys)

        validate_type(record, record.properties[:leds][0][:color], "Color", String)
        validate_values(record, record.properties[:leds][0][:color], "Color", %w(Red Amber Yellow Green Blue Unknown))

        validate_type(record, record.properties[:leds][0][:location], "Location", String)
        validate_values(record, record.properties[:leds][0][:location], "Location", ["Front panel", "Lightpath Card", "Planar", "FRU", "Rear Panel", "Unknown"])

        validate_type(record, record.properties[:leds][0][:name], "Name", String)

        validate_type(record, record.properties[:leds][0][:state], "State", String)
        validate_values(record, record.properties[:leds][0][:state], "State", %w(Off On Blinking Unknown))
      end

    end

    def validate_location(record)
      validate_type(record, record.properties[:location], "location", Hash)

      if record.properties[:location].is_a? Hash

        validate_hash_keys(record, record.properties[:location], "Location", %i(location lowestRackUnit rack room))

        %i(location rack room).each do |key|
          validate_type(record, record.properties[:location][key], key, String)
        end

        validate_type(record, record.properties[:location][:lowestRackUnit], "LowestRackUnit", Integer)
      end

    end

    def validate_nist(record)
      validate_type(record, record.properties[:nist], "Nist", Hash)

      if record.properties[:nist].is_a? Hash

        validate_type(record, record.properties[:nist][:currentValue], "CurrentValue", String)
        validate_values(record, record.properties[:nist][:currentValue], "CurrentValue", %w(Unknown Compatibility Nist_800_131A_Strict Nist_800_131A_Custom))

        validate_type(record, record.properties[:nist][:possibleValues], "PossibleValues", Array)
      end

    end

    def validate_power_allocation(record)
      validate_type(record, record.properties[:powerAllocation], "powerAllocation", Hash)

      if record.properties[:powerAllocation].is_a? Hash

        valid_values = %w(Normal)
        sub_keys = %i(allocatedOutputPower midPlaneCardMaximumAllocatedPower midPlaneCardMinimumAllocatedPower remainingOutputPower totalInputPower totalOutputPower)

        validate_hash_keys(record, record.properties[:powerAllocation], "PowerAllocation", sub_keys)
        sub_keys.each do |key|
          validate_type(record, record.properties[:powerAllocation][key], key, Fixnum)
        end
      end



    end

    def validate_security_policy(record)
      validate_type(record, record.properties[:securityPolicy], "securityPolicy", Hash)

      if record.properties[:SecurityPolicy].is_a? Hash
        sub_keys = %i(cmmPolicyLevel cmmPolicyState)
        cmm_policy_level_values = %w(LEGACY SECURE)
        cmm_policy_state_values = %w(ERROR UNKNOWN ACTIVE PENDING)

        validate_hash_keys(record, record.properties[:SecurityPolicy], "SecurityPolicy", sub_keys)
        validate_values(record, record.properties[:SecurityPolicy][:cmmPolicyLevel], "CmmPolicyLevel", cmm_policy_level_values)
        validate_values(record, record.properties[:SecurityPolicy][:cmmPolicyState], "CmmPolicyState", cmm_policy_state_values)
      end

    end

    def validate_status(record)
      validate_type(record, record.properties[:status], "status", Hash)

      if record.properties[:status].is_a? Hash
        sub_keys = %i(message name)

        validate_type(record, record.properties[:status], "Status", Hash)

        sub_keys.each do |key|

          if record.properties[:status][key].nil?
            record.errors[:base] << "Status attribute must contain #{key} attribute"
          elsif not record.properties[:status][key].is_a? String
            record.errors[:base] << "#{key} attribute must be a String (actual: #{record.properties[:status][key].class})"
          end
        end
      end

    end

    def validate_tls_version(record)
      validate_type(record, record.properties[:tlsVersion], "tlsVersion", Hash)

      if record.properties[:tlsVersion].is_a? Hash
        sub_keys = %i(currentValue possibleValues)
        valid_values = %w(Unknown SSL_30 TLS_10 TLS_11 TLS_12 TLS_12_Server_Client TLS_12_Server)

        if not record.properties[:tlsVersion].is_a? Hash
          record.errors[:base] << "TlsVersion attribute must be a Hash (actual: #{record.properties[:tlsVersion].class})"
        end

        sub_keys.each do |key|
          if record.properties[:tlsVersion][key].nil?
            record.errors[:base] << "TlsVersion attribute must contain #{key} attribute"
          end
        end

        if not record.properties[:tlsVersion][:currentValue].is_a? String
          record.errors[:base] << "CurrentValue attribute must be a String (actual: #{record.properties[:tlsVersion][:currentValue].class})"
        elsif not record.properties[:tlsVersion][:possibleValues].is_a? Array
          record.errors[:base] << "PossibleValues attribute must be a Array (actual: #{record.properties[:tlsVersion][:possibleValues].class})"
        end
      end
    end

    # these methods should not be included in the main validate method body because they are already called in other methods
    def validate_inner_chassis_bay(chassis_bay_array, record)

      chassis_bay_array.size.times do |i|
        validate_type(record, chassis_bay_array[i], "ChassisBay", Hash)
        validate_type(record, chassis_bay_array[i][:isExceeded], "isExceeded", String)
        validate_type(record, chassis_bay_array[i][:sensorName], "sensorName", String)
        validate_type(record, chassis_bay_array[i][:sensorValue], "sensorValue", Float)
        validate_type(record, chassis_bay_array[i][:slot], "slot", Integer)
        validate_type(record, chassis_bay_array[i][:subSlot], "subSlot", Integer)
      end
    end

    def validate_inner_hot_air_recirculation(hot_air_recirculation, record)
      validate_inner_chassis_bay(hot_air_recirculation[:chassisBay], record)

      isEnabled = [true, false]

      if not isEnabled.include? hot_air_recirculation[:isEnabled]
        record.errors[:base] << "IsEnabled attribute must be a boolean (actual: #{hot_air_recirculation[:isEnabled].class})"
      elsif not hot_air_recirculation[:maxVariation].is_a? Float
        record.errors[:base] << "MaxVariation attribute must be a Float (actual: #{hot_air_recirculation[:maxVariation].class})"
      end
    end

    def validate_inner_power_capping_policy(power_capping_policy, record)
      capping_policy_values = %w(OFF STATIC UNKNOWN)

      validate_type(record, power_capping_policy, "PowerCappingPolicy", Hash)
      validate_type(record, power_capping_policy[:cappingPolicy], "CappingPolicy", String)
      validate_values(record, power_capping_policy[:cappingPolicy], "CappingPolicy", capping_policy_values)
      validate_type(record, power_capping_policy[:currentPowerCap], "currentPowerCap", Fixnum)
      validate_type(record, power_capping_policy[:minPowerCap], "minPowerCap", Fixnum)

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

      if hash.is_a? Hash
        expected_keys.each do |key|
          if not hash.keys.include? key
            record.errors[:base] << "#{attribute_name} attribute must contain the key #{key}"
          end
        end
      end


    end
end
