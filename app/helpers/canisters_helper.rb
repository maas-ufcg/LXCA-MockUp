module CanistersHelper
  def self.required_fields
    %i(
      cmmDisplayName
    )
    #  backedBy

    # cmmHealthState
    # contact
    # dataHandle
    #  description
    # firmware FRU domainName driveBays drives errorFields ipInterfaces powerStatus
    # fruSerialNumber hardwareRevision manufacturer manufacturerID processorSlots
    # processors name parent partNumber posID slots subType powerState  subSlots
    # productId productName serviceHostName userDescription uri vnicMode uuid vpdID
  end
end
