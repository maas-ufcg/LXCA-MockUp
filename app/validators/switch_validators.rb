#require "../models/node"

class SwitchValidators < ActiveModel::Validator
	def validate(record)
		validate_uuid_and_id(record)
		validate_access_state(record)
		validate_apply_pending(record)
		validate_attached_nodes(record)
		validate_display_name(record)
		validate_health_state(record)
		validate_contact(record)
		#validate_cpu_utilization(record) TODO: See if type Long is correct.
		#validate_data_handle(record)	TODO: See if type Long is correct.
		validate_description(record)
		validate_dns_host_names(record)
		validate_domain_name(record)
		validate_entitle_serial_number(record)
	end

	private

	def validate_access_state(record_v)
		valid_values = ["Online", "Offline", "Partial", "Pending", "Unknown"]

		if record_v == nil
			record_v.errors[:base] << "AccessState attribute cannot be nil"
		elsif not record_v.properties[:accessState].is_a? String
			record_v.errors[:base] << "AccessState attribute must be of the type String"
		elsif not valid_values.include? record_v.properties[:accessState]
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
		#validates_associated :node
	end

	def validate_display_name(record_v)
		if record_v == nil
			record_v.errors[:base] << "CMMDisplayName attribute can't be nil"
		elsif not record_v.properties[:cmmDisplayName].is_a? String
			record_v.errors[:base] << "CMMDisplayName attribute must be a String"
		elsif record_v.properties[:cmmDisplayName] == ""
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

	def validate_uuid_and_id(record_v)
		if record_v == nil
			record_v.errors[:base] << "UUID attribute can't be nil"
		elsif record_v.properties[:uuid] == "" or record_v.properties[:uuid] == nil
			record_v.errors[:base] << "UUID attribute can't be nil or empty"
		elsif record_v.properties[:uuid] != record_v._id #Special Attention: Check access to the _id value in the switch model
			record_v.errors[:base] << "UUID attribute must be equal to the id attribute in the switch"
		end
	end

	def validate_contact(record_v)
		if record_v == nil
			record_v.errors[:base] << "Contact attribute can't be nil"
		elsif not record_v.properties[:contact].is_a? String
			record_v.errors[:base] << "Contact attribute must be of the type: String"
		elsif record_v.properties[:contact] == ""
			record_v.errors[:base] << "Contact attribute can't be empty"
		end
	end

	def validate_cpu_utilization(record_v)
		if record_v == nil
			record_v.errors[:base] << "CPU Utilization attribute can't be nil"
		elsif not record_v.properties[:cpuUtilization].is_a? Long
			record_v.errors[:base] << "CPU Utilization attribute must be a Long numeric value"
		elsif record_v.properties[:cpuUtilization] < 0
			record_v.errors[:base] << "CPU Utilization attribute can't be negative"
		end
	end

	def validate_data_handle(record_v)
		if record_v == nil
			record_v.errors[:base] << "Data Handle attribute can't be nil"
		elsif not record_v.properties[:dataHandle].is_a? Long
			record_v.errors[:base] << "Data Handle attribute must be a Long numeric value"
		elsif record_v.properties[:dataHandle] < 0
			record_v.errors[:base] << "Data Handle attribute can't be negative"
		end
	end

	def validate_description(record_v)
		if record_v == nil
			record_v.errors[:base] << "Description attribute can't be nil"
		elsif not record_v.properties[:description].is_a? String
			record_v.errors[:base] << "Description attribute must be os the type: String"
		elsif record_v.properties[:description] == ""
			record_v.errors[:base] << "Description attribute can't be empty"
		end
	end

	def validate_dns_host_names(record_v)
		if record_v == nil
			record_v.errors[:base] << "DNSHostnames attribute can't be nil"
		elsif not record_v.properties[:dnsHostnames].is_a? Array
			record_v.errors[:base] << "DNSHostnames attribute must be an Array of String values"
		else
			for dns in record_v.properties[:dnsHostnames]
				if not dns.is_a? String
					record_v.errors[:base] << "DNS Hostname attribute must contain only String values"
				end
			end
		end
	end

	def validate_domain_name(record_v)
		if record_v == nil
			record_v.errors[:base] << "Domain Name attribute can't be nil"
		elsif not record_v.properties[:domainName].is_a? String
			record_v.errors[:base] << "Domain Name attribute must be a String value"
		end
	end

	def validate_entitle_serial_number(record_v)
		if  record_v == nil
			record_v.errors[:base] << "Entitle Serial Number attribute can't be nil"
		elsif not record_v.properties[:entitleSerialNumber].is_a? String
			record_v.errors[:base] << "Entitle Serial Number attribute must be of the type: String"
		end
	end

end
