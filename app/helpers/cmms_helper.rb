module CmmsHelper
  def self.required_fields
    %i(accessState backedBy cmmDisplayName cmmHealthState dataHandle dnsHostName domainName errorFields excludedHealthState
    firmware FRU fruSerialNumber hostConfig hostname ipInterfaces ipv4Addresses ipv6Addresses
    macAddresses machineType mgmtProcIPaddress model name overallHealthState parent
    partNumber powerAllocation productID roleserialNumber slots type userDescription uri uuid
    )
  end

def self.possible_values_per_field
  {
    accessState: ["Online", "Offline", "Partial", "Pending", "Unknown"],
    backedBy: ["real", "demo", "proxy"],
    cmmHealthState: ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"],
    errorFields: ["FETCH_SUCCESS", "FETCH_FAILED", "NO_CONNECTOR", "FATAL_EXCEPTION", "NETWORK_FAIL"],
    excludedHealthState: ["Normal", "Non-Critical", "Warning", "Minor-Failure", "Major-Failure", "Non-Recoverable", "Critical", "Unknown"],
    name: ["Front panel", "Lightpath Card", "Planar", "FRU", "Rear Panel", "Unknown"],
    role: ["primary", "backup"]
  }

end

end
