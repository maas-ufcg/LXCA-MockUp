module CanistersHelper
  def self.required_fields
    %i(
    activationKeys bladeState cmmDisplayName cmmHealthState backedBy contact dataHandle  description
   firmware FRU domainName driveBays drives errorFields ipInterfaces powerStatus ipv6Addresses
   fruSerialNumber manufacturer manufacturerID processorSlots leds ipv4Addresses hostname
   processors name parent posID productId productName model location lanOverUsb ipv4ServiceAddress
   serviceHostName userDescription uri vnicMode uuid vpdID macAddress ipv6ServiceAddress
   subSlots subType slots serialNumber posId partNumber memorySlots memoryModules machineType
    )
  end
end
