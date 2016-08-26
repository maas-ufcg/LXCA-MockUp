module SwitchesHelper

  def self.required_fields
     %i(accessState attachedNodes cmmHealthState firmware ipInterfaces macAddress productName serialNumber type uuid)
  end

  def self.defined_fields
    %i(accessState cmmHealthState excludedHealthState)
  end

end
