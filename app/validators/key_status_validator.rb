class KeyStatusValidator < ActiveModel::Validator

  def validate(record)
    validValues = [:UNKNOWN, :OTHER, :VALID, :INVALID, :INPROCESS, :EXPIRED, :LIMIT_REACHED, :NEED_VALID_ELSEWHERE,:KEY_NOT_FOUND]
    
    if not validValues.include? record.properties[:activationKeys][:keyIdentiferList][:keyIdentifierType]
      record.errors[:base] << "KeyStatus attribute is not valid."
    end
  end
end
