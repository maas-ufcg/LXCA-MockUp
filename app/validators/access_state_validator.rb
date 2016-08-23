class AccessStateValidator < ActiveModel::Validator

  def validate(record)
    validValues = ["Online", "Offline", "Partial", "Pending", "Unknown"]

    if not validValues.include? record.properties[:accessState]
      record.errors[:base] << "AccessState attribute is not valid"
    end
  end
end
