class ChassiValidators < ActiveModel::Validator
  def validate(record)
    if record == nil
      record.errors[:base] << "Record cannot be nil"
    end

      validate_access_state(record)
      validate_activation_keys(record)
      validate_active_alerts(record)

  end

  private
  def validate_access_state(record)
    valid_values = %w(Online Offline Partial Pending Unknown)

    if not record.properties[:accessState].is_a? String
      record.errors[:base] << "AccessState attribute must be a String"
    elsif not valid_values.include? record.properties[:accessState]
      record.errors[:base] << "AccessState attribute is not valid"
    end
  end

    def validate_activation_keys(record)
      if not record.is_a? Array
        record.errors[:base] << "ActivationKeys attribute must be an Array"
      end
  end

    def validate_active_alerts(record)
      sub_keys = %w(corrIDs id location msg msgID severity)
      severity = %w(FATAL CRITICAL MAJOR MINOR WARNING INFORMATIONAL UNKNOWN)

      if not record.properties[:activeAlerts].is_a? Hash
        record.errors[:base] << "ActiveAlerts attribute must be a Hash"
      end

      sub_keys.each do |key|
        if record.properties[:activeAlerts][:key] == nil
          record.errors[:base] << "ActiveAlerts hash must contain #{key} attribute"
        elsif not record.properties[:activeAlerts][:key].is_a? String
          record.errors[:base] << "#{key} must be a String"
        end
      end

      if not severity.include? record.properties[:activeAlerts][:severity]
        record.errors[:base] << "Severity attribute is not valid."
      end
    end

end
