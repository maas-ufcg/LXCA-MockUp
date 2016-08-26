module NodesHelper
  def self.required_fields
    %i(
      accessState activationKeys keyExpirationDate keyIdentifierType keyFeatureType keyStatus uuid addinCardSlots
      keyUseCount keyUseLimit addinCards isAddOnCard isAgentless portInfo portType portNumber logicalPorts
      addresses vnicMode productName slotName slotNumber slotSupportsHotPlug arch backedBy bladeState bootMode
      bootOrder canisters canisterSlots cmmDisplayName cmmHealthState complexID contact dataHandle dnsHostnames domainName
      driveBays drives embeddedHypervisorPresence encapsulationMode errorFields excludedHealthState expansionCardSlots expansionCards
      expansionProductType expansionProducts expansionProductSlots firmware flashStorage fruSerialNumber hostMacAddresses hostname ipInterfaces
      ipv4Addresses ipv6Addresses isConnectionTrusted isITME isRemotePresenceEnabled isScalable lanOverUsb location logicalID
      macAddress machineType manufacturer manufacturerID memoryModules memorySlots mgmtProcIPaddress model nist onboardPciDevices
      overallHealthState parent parentComplexID parentPartitionUUID partNumber partitionID partitionEnabled pciCapabilities
      pciDevices pciExpressCards pciExpressCardSlots physicalID ports posID powerAllocation powerCappingPolicy powerStatus
      powerSupplies primary processorSlots processors productID raidSettings secureBootMode serialNumber slots status subSlots
      subType thinkServerFru tlsVersion type uri userDescription vpdID
    )
  end
end
