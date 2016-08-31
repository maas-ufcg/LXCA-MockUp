module NodesHelper
  def self.required_fields
    %i(
      accessState activationKeys uuid addinCardSlots
      addinCards 
      vnicMode productName arch backedBy bladeState bootMode
      bootOrder canisters canisterSlots cmmDisplayName cmmHealthState complexID dataHandle dnsHostnames domainName
      driveBays embeddedHypervisorPresence errorFields excludedHealthState expansionCardSlots expansionCards
      expansionProductType expansionProducts expansionProductSlots firmware flashStorage fruSerialNumber hostMacAddresses hostname ipInterfaces
      ipv4Addresses ipv6Addresses isConnectionTrusted isITME hasOS isRemotePresenceEnabled isScalable lanOverUsb
      machineType manufacturer manufacturerID memoryModules memorySlots mgmtProcIPaddress model nist onboardPciDevices
      overallHealthState partitionEnabled powerStatus pciExpressCards pciExpressCardSlots physicalID ports posID powerAllocation powerCappingPolicy
      powerSupplies primary processorSlots processors productID raidSettings secureBootMode serialNumber slots status subSlots
      thinkServerFru tlsVersion type uri userDescription vpdID
    )
  end

  def self.possible_values_per_sub_field
    {
      keyIdentifierType: ["ASIC", "MAC", "MT", "UNKNOWN"],
      keyStatus: ["UNKNOWN", "OTHER", "VALID", "INVALID", "INPROCESS", "EXPIRED", "LIMIT_REACHED", "NEED_VALID_ELSEWHERE", "KEY_NOT_FOUND"],
      role: ["Primary", "Backup", "Temporary", "Permanent"],
      bootType: ["Permanent", "SingleUse", "WakeOnLan", "Unknown"],
      raidPresence: ["Regular", "Non-RAID drive"],
      encapsulationMode: ["notSupported", "normal", "encapsulationLite"],
      errorCode: ["FETCH_SUCCESS", "FETCH_FAILED", "NO_CONNECTOR", "FATAL_EXCEPTION", "NETWORK_FAIL"],
      IPv4DHCPmode: ["STATIC_ONLY", "DHCP_ONLY", "DHCP_THEN_STATIC", "UNKNOWN"],
      firmware_types: %w(UEFI MP DSA),
      firmware_roles: %w(Primary Backup Temporary Permanent),
      firmware_status: %w(Active Inactive),
      port_few_types: ["ATM","ETHERNET", "FC", "FDDI", "FRAMERELAY", "IB", "OTHER", "TOKENRING", "UNKNOWN"],
      port_types: %w(ATM BLUETOOTH ETHERNET FC FDDI FRAMERELAY IB INFRARED OTHER TOKENRING UNKNOWN WIRELESSLAN),
      health_states: %w(Normal Non-Critical Warning Minor-Failure Major-Failure Non-Recoverable Critical Unknown)
    }
  end

  def self.possible_values_per_field
    {
      accessState: ["Online", "Offline", "Partial", "Pending", "Unknown"],
      vnicMode: ["enabled", "disabled"],
      arch: ["ia64", "ppc", "ppc64", "x86", "x86_64", "Unknown"],
      backedBy: ["real", "demo", "proxy"],
      cmmHealthState: ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown", "Informational", "Minor", "Major", "Critical", "Fatal"],
      excludedHealthState: ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"],
      expansionProductType: ["SEN", "PEN", "Expansion card", "Addin Card", "PCI Express Card", "Unknown"],
      expansionProducts: ["expansionProducts", "expansionCards", "addinCards", "pciExpressCards"],
      hasOS: ["true", "false"],
      lanOverUsb: ["enabled", "disabled"],
      overallHealthState: ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"],
      powerStatus: [0, 5, 8, 18],
      type: ["ITE", "Rack-Tower Server", "Lenovo ThinkServer", "SCU"]
    }
  end
end
