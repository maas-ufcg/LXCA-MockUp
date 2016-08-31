module CmmsHelper
  def self.required_fields
    %i(accessState backedBy cmmDisplayName cmmHealthState dataHandle dnsHostName domainName errorFields excludedHealthState
    firmware FRU fruSerialNumber hostConfig hostname ipInterfaces ipv4Addresses ipv6Addresses
    macAddresses machineType mgmtProcIPaddress model name overallHealthState parent
    partNumber powerAllocation productID roleserialNumber slots type userDescription uri uuid
    )
  end
end
