class SwitchValidators < ActiveModel::Validator
	def validate(record)
		validate_properties(record)
		validate_keys(record)
		validate_uuid(record)
		validate_uuid_and_id(record)
		validate_AT_values(record)
		validate_HS_values(record)
		validate_EHS_value(record)
		validate_OHS_value(record)
		validate_panicDump_values(record)
		validate_powerState_values(record)
		validate_protectedMode_values(record)
		validate_savePending_values(record)
		validate_stackedMode_values(record)
	end

	private



	def validate_keys(record_v)
		SwitchesHelper::required_fields.each do |key|
			if record_v.properties[key].nil?
				record_v.errors[:base] << "inconsistent object, missing propertie #{key}."
				break
			end
		end

	end

	def validate_properties(record_v)
		if record_v.nil?
			record_v.errors[:base] << "nil object is not valid."
		elsif record_v.properties.nil?
			record_v.errors[:base] << "properties cannot be nil."
		elsif  not record_v.properties.is_a? Hash
				record_v.errors[:base] << "properties only should be a Hash."
		end
	end


def validate_uuid_and_id(record_v)
		if record_v.nil?
			record_v.errors[:base] << "UUID attribute can't be nil"
		elsif  record_v.properties[:uuid].nil? or record_v.properties[:uuid] == ""
			record_v.errors[:base] << "UUID attribute can't be nil or empty"
		elsif record_v.properties[:uuid] != record_v._id #Special Attention: Check access to the _id value in the switch model
			record_v.errors[:base] << "UUID attribute must be equal to the id attribute in the switch"
		end
	end

	def validate_uuid(record_v)
		if record_v.nil?
			record_v.errors[:base] << "nil object is not valid."
		elsif record_v.properties[:uuid].nil?
			record_v.errors[:base] << "UUID attribute can't be nil."
		elsif record_v.properties[:uuid] == ""
			record_v.errors[:base] << "UUID attribute can't be empty."
		end
	end

	def validate_AT_values(record_v)
		valid_values = ["Online", "Offline", "Partial", "Pending", "Unknown"]

		if not valid_values.include? record_v.properties[:accessState].to_s
			record_v.errors[:base] << "Access State value is not valid."
		end
	end

	def validate_HS_values(record_v)
		valid_values = ["Normal", "Non-Critical","Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"]

		if not valid_values.include? record_v.properties[:cmmHealthState]
			record_v.errors[:base] << "CMM Health State value is not valid."
		end
	end

	def validate_EHS_value(record_v)
		valid_values = ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"]

		if not valid_values.include? record_v.properties[:excludedHealthState]
			record_v.errors[:base] << "Excluded Health State value is not valid."
		end
	end

	def validate_OHS_value(record_v)
		valid_values = ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"]

		if not valid_values.include? record_v.properties[:overallHealthState]
			record_v.errors[:base] << "Overall Health State value is not valid."
		end
	end

	def validate_panicDump_values(record_v)
		valid_values = ["Yes", "No"]

		if not valid_values.include? record_v.properties[:panicDump]
			record_v.errors[:base] << "Panic Dump value is not valid."
		end
	end

	def validate_powerState_values(record_v)
		valid_values = ["Off",  "On", "ShuttingDown", "Standby", "Hibernate", "Unknown"]

		if not valid_values.include? record_v.properties[:powerState]
			record_v.errors[:base] << "Power State value is not valid"
		end
	end

	def validate_protectedMode_values(record_v)
		valid_values = [true, false]
		if not valid_values.include? record_v.properties[:protectedMode]
			record_v.errors[:base] << "Protected Mode value is not valid."
		end
	end

	def validate_savePending_values(record_v)
		valid_values = ["yes", "no"]
		if not valid_values.include? record_v.properties[:savePending]
			record_v.errors[:base] << "Save Pending value is not valid."
		end
	end

	def validate_stackedMode_values(record_v)
		valid_values = [true, false]
		if not valid_values.include? record_v.properties[:stackMode]
			record_v.errors[:base] << "Stacked Mode value is not valid."
		end
	end



#TODO check validators for invalid values in an Array
	def validate_IPV4Ass_values(record_v)
		valid_values = ["INUSE", "CONFIGURED", "ALIAS", "UNKNOWN"]

		if not valid_values.include? record_v.properties[:ipInterfaces[:ipv4_assignment]] [3]
			record_v.errors[:base] << "IPV4 Assingment type not valid."
		end
	end

	def validate_IPV4DHCP_values(record_v)
		valid_values = ["STATIC_ONLY", "DHCP_ONLY", "DHCP_THEN_STATIC", "UNKNOWN"]

		if not valid_values.include? record_v.properties[:ipInterfaces[:IPv4DHCPmode]]
			record_v.errors[:base] << "IPV4 DHCP Mode value is not valid"
		end
	end

end
