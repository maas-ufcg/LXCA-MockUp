class ScalableComplexValidators < ActiveModel::Validator

  def validate(record)
    validate_properties(record)
    validate_keys(record)
    validate_uuid(record)
    validate_uuid_and_id(record)
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

  private #methods to validate values

  def validate_properties(record_v)
  		if record_v.nil?
  			record_v.errors[:base] << "nil object is not valid."
  		elsif record_v.properties.nil?
  			record_v.errors[:base] << "properties cannot be nil."
  		elsif  not record_v.properties.is_a? Hash
  				record_v.errors[:base] << "properties only should be a Hash."
  		end
  end

  def validate_keys(record_v)
		ScalableComplexHelper::required_fields.each do |key|
			if record_v.properties[key].nil?
				record_v.errors[:base] << "inconsistent object, missing property #{key}."
				break
			end
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

  def validate_uuid_complexID (record_v)
    if record_v.nil?
      record_v.errors[:base] << "Invalid, the complex ID and the UUID attribute must be equals"
    elsif record_v.properties[:uuid] != record_v._id
      record_v.errors[:base] << "Invalid, the complex ID and the UUID attribute must be equals"
    end
  end


end
