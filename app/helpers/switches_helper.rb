module SwitchesHelper

  def self.required_fields
     %i(accessState applyPending attachedNodes cmmDisplayName cmmHealthState entitleSerialNumber fans firmware hostname ipInterfaces leds macAddress manufacturer manufacturerID ports productID productName protectedMode serialNumber type upTime uri uuid)
  end

  def self.defined_fields
    %i(accessState cmmHealthState excludedHealthState overallHealthState panicDump powerState savePending)
  end

  def self.params_white_list
      %i(contact cpuUtilization dataHandle description dnsHostnames errorFields FRU fruSerialNumber ipv4Address ipv6Address ipInterfaces manufacturingDate memoryUtilization sysObjectID model slots stackedMode stackRole name resetReason temperatureSensors userDescription vpdID)
  end

  def self.fields_put_params
    %i(refreshInventory leds)
  end

end

