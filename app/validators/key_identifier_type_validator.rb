class KeyIdentifierTypeValidator < ActiveModel::Validator

  def validate(record)
    validValues = [:ASIC, :MAC, :MT, :UNKNOWN]
    
    if not validValues.include? record.properties[:activationKeys][:keyIdentiferList][:keyIdentifierType]
      record.errors[:base] << "KeyIdentifierType attribute is not valid."
    end
  end
end
