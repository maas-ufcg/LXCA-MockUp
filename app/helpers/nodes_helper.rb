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
      overallHealthState partitionEnabled cappingACorDCMode cappingPolicy powerStatus healthState pciExpressCards pciExpressCardSlots physicalID ports posID powerAllocation powerCappingPolicy
      powerSupplies primary processorSlots processors productID raidSettings secureBootMode serialNumber slots status subSlots
      subType thinkServerFru tlsVersion type uri userDescription vpdID
    )
  end

  def self.possible_values_per_field
    {
      accessState: ["Online", "Offline", "Partial", "Pending", "Unknown"],
      keyIdentifierType: ["ASIC", "MAC", "MT", "UNKNOWN"],
      keyStatus: ["UNKNOWN", "OTHER", "VALID", "INVALID", "INPROCESS", "EXPIRED", "LIMIT_REACHED", "NEED_VALID_ELSEWHERE", "KEY_NOT_FOUND"],
      role: ["Primary", "Backup", "Temporary", "Permanent"],
      isAddOnCard: [true, false],
      isAgentless: [true, false],
      portType: ["ATM","ETHERNET", "FC", "FDDI", "FRAMERELAY", "IB", "OTHER", "TOKENRING", "UNKNOWN"],
      slotSupportsHotPlug: [true, false],
      arch: ["ia64", "ppc", "ppc64", "x86", "x86_64", "Unknown"],
      backedBy: ["real", "demo", "proxy"],
      bladeState: (0..17),
      bootType: ["Permanent", "SingleUse", "WakeOnLan", "Unknown"],
      cmmHealthState: ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown", "Informational", "Minor", "Major", "Critical", "Fatal"],
      raidPresence: ["Regular", "Non-RAID drive"],
      state: ["active", "stopped", "transitioning"],
      embeddedHypervisorPresence: [true, false],
      ncapsulationMode: ["notSupported", "normal", "encapsulationLite"],
      errorFields: ["FETCH_SUCCESS", "FETCH_FAILED", "NO_CONNECTOR", "FATAL_EXCEPTION", "NETWORK_FAIL"],
      excludedHealthState: ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"],
      vnicMode: [true, false],
      expansionProductType: ["SEN", "PEN", "Expansion card", "Addin Card", "PCI Express Card", "Unknown"],
      expansionProducts: ["expansionProducts", "expansionCards", "addinCards", "pciExpressCards"],
      hasOS: [true, false],
      IPv4DHCPmode: ["STATIC_ONLY", "DHCP_ONLY", "DHCP_THEN_STATIC", "UNKNOWN"],
      IPv4enabled: [true, false],
      IPv6enabled: [true, false],
      isConnectionTrusted: [true, false],
      isRemotePresenceEnabled: [true, false],
      isScalable: [true, false],
      lanOverUsb: ["enabled", "disabled"],
      currentValue: ["Unknown", "Compatibility", "Nist_800_131A_Strict", "Nist_800_131A_Custom"],
      overallHealthState: ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"],
      partitionEnabled: [true, false],
      cappingACorDCMode: ["AC", "DC", "Unknown"],
      cappingPolicy: ["OFF", "STATIC", "UNKNOWN"],
      powerStatus: [0, 5, 8, 18],
      healthState:["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"],
      primary: [true, false],
      type: ["ITE", "Rack-Tower Server", "Lenovo ThinkServer", "SCU"]
    }
  end
end
