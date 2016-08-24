module PowerSuppliesHelper
  def self.required_fields
  %i(
    cmmDisplayName cmmHealthState dataHandle description firmware FRU
    fruSerialNumber hardwareRevision inputVoltageIsAC inputVoltageMax inputVoltageMin
    LEDs manufacturer manufactureDate manufacturerID
    name parent partNumber posID powerAllocation powerState productID productName
     serialNumber slots type uri userDescription uuid vpdID
  )
end
end
