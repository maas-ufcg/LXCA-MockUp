module SwitchesHelper

  def self.required_fields
     %i(accessState attachedNodes cmmHealthState firmware ipInterfaces macAddress productName serialNumber type uuid)
  end

  def self.invalid_fields
    %i(accessState cmmHealthState excludedHealthState)
  end

  def self.params_white_list
      %i(hostname  ipv4Address ipv6Address ipInterfaces)
  end

  def self.fields_put_params
    %i(powerState refreshInventory leds)
  end

end
