module ChassisHelper
  def self.required_fields
    %i(
      accessState activationKeys activeAlerts backedBy bladeSlots cmmDisplayName
      cmmHealthState cmms cmmSlots complex contact dataHandle description domainName
      encapsulation energyPolicies errorFields excludedHealthState fanMuxes fanMuxSlots
      fans fanSlots height hostname isConnectionTrusted ledCardSlots leds location machineType
      managerName managerUuid manufacturer manufacturerID mgmtProcIPaddress model nist nodes
      partNumber passThroughModules posID powerAllocation PowerSupplySlots powerSupplies
      productID overallHealthState SecurityPolicy serialNumber status switches switchSlots
      tlsVersion type userDescription uri uuid vpdID
    )
  end
end
