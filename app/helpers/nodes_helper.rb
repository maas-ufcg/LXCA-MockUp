module NodesHelper
  def self.required_fields
    %i(
      accessState activationKeys keyIdentifierType keyFeatureType keyStatus uuid addinCardSlots
      keyUseCount keyUseLimit role addinCards isAddOnCard isAgentless portInfo portType portNumber logicalPorts
      addresses vnicMode productName slotName slotNumber slotSupportsHotPlug arch backedBy bladeState bootMode
      bootOrder canisters canisterSlots cmmDisplayName cmmHealthState complexID contact dataHandle dnsHostnames domainName
      driveBays raidPresence state embeddedHypervisorPresence encapsulationMode errorFields excludedHealthState expansionCardSlots expansionCards
      expansionProductType expansionProducts expansionProductSlots firmware flashStorage fruSerialNumber hostMacAddresses hostname ipInterfaces
      ipv4Addresses ipv6Addresses isConnectionTrusted isITME hasOS IPv4DHCPmode IPv4enabled IPv6enabled isRemotePresenceEnabled isScalable lanOverUsb
      currentValue machineType manufacturer manufacturerID memoryModules memorySlots mgmtProcIPaddress model nist onboardPciDevices
      overallHealthState partitionEnabled cappingACorDCMode cappingPolicy powerStatus pciExpressCards pciExpressCardSlots physicalID ports posID powerAllocation powerCappingPolicy
      powerSupplies primary processorSlots processors productID raidSettings secureBootMode serialNumber slots status subSlots
      subType thinkServerFru tlsVersion type uri userDescription vpdID
    )
  end
end
