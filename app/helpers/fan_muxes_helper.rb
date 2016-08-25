module FanMuxesHelper
  def self.required_fields
    %i(
      cmmDisplayName cmmHealthState dataHandle description FRU
      fruSerialNumber hardwareRevision leds machineType manufacturer manufactureDate
      manufacturerID model name parent partNumber productID productName serialNumber
      slots status type uri uuid
    )
  end
end
