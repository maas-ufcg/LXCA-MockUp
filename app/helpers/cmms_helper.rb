module CmmsHelper
  def self.required_fields
    %i(accessState backedBy cmmDisplayName cmmHealthState dataHandle dnsHostNames domainName errorFields excludedHealthState
    firmware FRU fruSerialNumber hostConfig hostname ipInterfaces ipv4Addresses ipv6Addresses
    macAddresses machineType mgmtProcIPaddress model name overallHealthState parent
    partNumber powerAllocation productID role serialNumber slots type userDescription uri uuid
    )
  end

def self.possible_values_per_field
  {
    boolean: [true, false],
    accessState: ["Online", "Offline", "Partial", "Pending", "Unknown"],
    backedBy: ["real", "demo", "proxy"],
    cmmHealthState: ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"],
    errorCode: ["FETCH_SUCCESS", "FETCH_FAILED", "NO_CONNECTOR", "FATAL_EXCEPTION", "NETWORK_FAIL"],
    excludedHealthState: ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"],
    role: ["primary", "backup"],
    IPversionPriority: %w(IPv6ThenIPv4),
    ip_interfaces_ipv4assignments_type: %w(INUSE CONFIGURED ALIAS UNKNOWN),
    ip_interfaces_IPv4DHCPmode: %w(STATIC_ONLY DHCP_ONLY DHCP_THEN_STATIC UNKNOWN),
    ip_interfaces_ipv6assignments_scope: %w(Global LinkLocal Unknown),
    ip_interfaces_ipv6assignments_source: %w(DHCP Stateless Static Other Unknown),
    ip_interfaces_ipv6assignments_type: %w(INUSE CONFIGURED ALIAS UNKNOWN),

    leds_color: %w(Red Amber Yellow Green Blue Unknown),
    leds_location: ["Front panel", "Lightpath Card", "Planar", "FRU", "Rear Panel", "Unknown"],
    leds_state: ["Off", "On", "Blinking", "Unknown"],

    name: ["Front panel", "Lightpath Card", "Planar", "FRU", "Rear Panel", "Unknown"],


  }

end

def self.field_put_params
    %i(domain_name host_config hostname ip_interfaces)
end


end
