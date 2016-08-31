module FansHelper
  def self.required_fields
    %i(
      cmmDisplayName cmmHealthState dataHandle firmware FRU
      fruSerialNumber hardwareRevision manufacturer manufacturerID
      name parent partNumber posID powerState uri uuid vpdID
    )
  end
end
