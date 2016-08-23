class SwitchValidators << ActiveModel::Validator
	def validate(record)
		#call private specific methods of validation bellow
	end

	private

	def validate_access_state(record_v)
		valid_values = ["Online", "Offline", "Partial", "Pending", "Unknown"]

		if record_v == nil
			record_v.errors[:base] << "AccessState attribute cannot be nil"
		elsif not record_v.properties[:AccessState].is_a? String 
			record_v.errors[:base] << "AccessState attribute must be of the type String"
		elsif not valid_values.include? record_v.properties[:AccessState]
			record_v.errors[:base] << "AccessState attribute is not valid"
		end
	end

	def validate_apply_pending(record_v)
		if record_v == nil
			record_v.errors[:base] << "ApllyPending attribute can't be nil"
		elsif not record_v.properties[:applyPending].is_a? Integer
			record_v.errors[:base] << "ApllyPending attribute must be an Integer value"
		end
	end

	def validate_attached_nodes(record_v)
		if record_v == nil
			record_v.errors[:base] << "AttachedNodes attribute can't be nil"
		elsif not record_v.properties[:attachedNodes].is_a? Array
			record_v.errors[:base] << "AttachedNodes attribute must be an array of nodes values"
		end
	end

	def validate_display_name(record_v)
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
end
