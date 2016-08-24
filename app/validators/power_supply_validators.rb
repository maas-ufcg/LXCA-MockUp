class PowerSuppliesValidators < ActiveModel::Validator
	def validate(record)
		validate_cmm_display_name(record)
		validate_health_state(record)
		validate_data_handle(record)
	end

  private

  def validate_cmm_display_name(record_v)
		if record_v == nil
			record_v.errors[:base] << "CMMDisplayName attribute can't be nil"
		elsif not record_v.properties[:cmmHealthState].is_a? String
			record_v.errors[:base] << "CMMDisplayName attribute must be a String"
		elsif record_v.properties[:cmmHealthState] == ""
			record_v.errors[:base] << "CMMDisplayName attribute can't be empty"
		end
	end

  def validate_health_state(record_v)
		valid_values = ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"]

		if record_v == nil
			record_v.errors[:base] << "CMMHealthState attribute can't be nil"
		elsif not record_v.properties[:cmmHealthState].is_a? String
			record_v.errors[:base] << "CMMHealthState attribute must be a String"
		elsif not valid_values.include? record_v.properties[:cmmHealthState]
			record_v.errors[:base] << "CMMHealthState attribute is not valid"
		end
	end

  def validate_data_handle(record_v)
    if record_v == nil
			record_v.errors[:base] << "CMMDisplayName attribute can't be nil"
		elsif not record_v.properties[:cmmHealthState].is_a? Long
			record_v.errors[:base] << "CMMDisplayName attribute must be a Long"
		elsif record_v.properties[:cmmHealthState] == ""
			record_v.errors[:base] << "CMMDisplayName attribute can't be empty"
		end
	end
end
