module CanistersHelper
  def self.required_fields
    %i(
      cmmDisplayName backedBy contact dataHandle  description
      firmware FRU domainName driveBays drives errorFields ipInterfaces powerStatus
      fruSerialNumber manufacturer manufacturerID processorSlots
      processors name parent posID productId productName
      serviceHostName userDescription uri vnicMode uuid vpdID
    )
  end
end
