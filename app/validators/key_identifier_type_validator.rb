class KeyIdentifierTypeValidator < ActiveModel::Validator
  validValues = [:ASIC, :MAC, :MT, :UNKNOWN]

  def validate(record)
    if not validValues.include? record.properties[:activationKeys][:keyIdentiferList][:keyIdentifierType]
      record.errors[:base] << "KeyIdentifierType attribute is not valid."
    end
  end
end
