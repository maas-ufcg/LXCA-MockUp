class ChassiValidators < ActiveModel::Validator
  def validate(record)
    if record == nil
      record.errors[:base] << "Record cannot be nil"
    end

      validate_access_state(record)
      validate_activation_keys(record)
      validate_active_alerts(record)
      ### Include the others methods
      validate_type(record, :cmms, Array)
      validate_type(record, :cmmSlots, Integer)
      validate_type(record, :complex, Array)
      validate_type(record, :contact, String)
      validate_type(record, :dataHandle, Fixnum)
      validate_type(record, :description, String)
      validate_type(record, :domainName, String)

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
        if alert == nil
          record.errors[:base] << "Alert attribute cannot be nil"
        elsif not alert.is_a? Hash
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

    # def validate_cmms(record)
    #   if not record.properties[:cmms].is_a? Array
    #     record.errors[:base] << "Cmms attribute must be an array (actual: #{record.properties[:cmms].class})"
    #   end
    # end
    #
    # def validate_cmm_slots(record)
    #   if not record.properties[:cmmSlots].is_a? Integer
    #     record.errors[:base] << "CmmSlots attribute must be an Integer (actual: #{record.properties[:cmmSlots].class})"
    #   end
    # end
    #
    # def validate_complex(record)
    #   if not record.properties[:complex].is_a? Array
    #     record.errors[:base] << "Complex attribute must be an Array (actual: #{record.properties[:complex].class})"
    #   end
    # end
    #
    # def validate_contact(record)
    #   if not record.properties[:contact].is_a? String
    #     record.errors[:base] << "Contact attribute must be a String (actual: #{record.properties[:contact].class})"
    #   end
    # end
    #
    # def validate_data_handle(record)
    #   if not record.properties[:dataHandle].is_a? Fixnum
    #     record.errors[:base] << "DataHandle attribute must be a Fixnum (actual: #{record.properties[:dataHandle].class})"
    #   end
    # end
    #
    # def validate_description(record)
    #   if not record.properties[:description].is_a? String
    #     record.errors[:base] << "Description attribute must be a String (actual: #{record.properties[:description].class})"
    #   end
    # end
    #
    # def validate_domain_name(record)
    #   if not record.properties[:domainName].is_a? String
    #     record.errors[:base] << "DomainName attribute must be a String (actual: #{record.properties[:domainName].class})"
    #   end
    # end

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
      elsif not encapsulatin,on_mode.include? record.properties[:encapsulation][:encapsulationMode]
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
        recordo.errors[:base] << "ErrorFields attribute must be a Array (actual: #{record.properties[:errorFields].class})"
      elsif not valid_values.included? record.properties[:errorFields][:errorCode]


      end
    end

    def validate_excluded_health_state(record)
      valid_values = %W(Normal Non-Critical Warning Minor-Failure Major-Failure Non-Recoverable Critical Unknown)

      if not record.properties[:excludedHealthState].is_a? String
        record.errors[:base] << "ExcludedHealthState must be a String (actual: #{record.properties[:excludedHealthState].class})"
      end


    end

    # this method should not be included in the main validate method body
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

      if not power_capping_policy.is_a? Hash
        record.errors[:base] >> "PowerCappingPolicy attribute must be a Hash (actual: #{power_capping_policy.class}"
      elsif not power_capping_policy[:cappingPolicy].is_a? String
        record.errors[:base] >> "CappingPolicy attribute must be a String (actual: #{power_capping_policy[:cappingPolicy].class}"
      elsif not capping_policy_values.include? power_capping_policy[:cappingPolicy]
        record.errors[:base] >> "CappingPolicy attribute is not valid"
      elsif not power_capping_policy[:currentPowerCap].is_a? Fixnum
        record.errors[:base] >> "CurrentPowerCap attribute must be a Fixnum (actual: #{power_capping_policy[:currentPowerCap].class}"
      elsif not power_capping_policy[:maxPowerCap].is_a? Fixnum
        relsif not power_capping_policy[:maxPowerCap].is_a? Fixnum
          record.errors[:base] >> "MaxPowerCap attribute must be a Fixnum (actual: #{power_capping_policy[:maxPowerCap].class}"ecord.errors[:base] >> "MaxPowerCap attribute must be a Fixnum (actual: #{power_capping_policy[:maxPowerCap].class}"
      elsif not power_capping_policy[:minPowerCap].is_a? Fixnum
        record.errors[:base] >> "MinPowerCap attribute must be a Fixnum (actual: #{power_capping_policy[:minPowerCap].class}"
      end
    end



    def validate_type(record, key, type_expected)
      if not record.properties[key].is_a? type_expected
        record.errors[:base] << "#{key} attribute must be a/an #{type_expected} (actual: #{record.properties[key].class})"
      end
    end

end
