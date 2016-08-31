module SwitchesHelper

  def self.required_fields
     %i(accessState attachedNodes cmmHealthState firmware hostname ipInterfaces leds macAddress productName protectedMode serialNumber type uuid)
  end

  def self.defined_fields
    %i(accessState cmmHealthState excludedHealthState overallHealthState panicDump powerState)
  end

  def self.params_white_list
      %i(contact hostname  ipv4Address ipv6Address ipInterfaces)
  end

  def self.fields_put_params
    %i(refreshInventory leds)
  end

end
