class AccessStateValidator < ActiveModel::Validator
  validValues = [:Online, :Offline, :Partial, :Pending, :Unknown]

  def validate(record)
    if not validValues.include? record.properties[:accessState]
      record.errors[:base] << "AccessState attribute is not valid."
    end
  end
end
