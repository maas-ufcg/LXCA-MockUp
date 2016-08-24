module SwitchesHelper

  def self.required_fields
     %i(accessState attachedNodes cmmHealthState firmware macAddress productName serialNumber type uuid)
  end

end
