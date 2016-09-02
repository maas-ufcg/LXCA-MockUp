module ChassisHelper
  def self.required_fields
    %i(
      accessState activationKeys activeAlerts backedBy bladeSlots cmmDisplayName
      cmmHealthState cmms cmmSlots complex contact dataHandle description domainName
      encapsulation energyPolicies errorFields excludedHealthState fanMuxes fanMuxSlots
      fans fanSlots height hostname isConnectionTrusted ledCardSlots leds location machineType
      managerName managerUuid manufacturer manufacturerID mgmtProcIPaddress model nist nodes
      partNumber passThroughModules posID powerAllocation powerSupplySlots powerSupplies
      productID overallHealthState securityPolicy serialNumber status switches switchSlots
      tlsVersion type userDescription uri uuid vpdID
    )
  end

  def self.field_put_params
    %w(
      properties policy led cmm tls encapsulation_mode
    )
  end

  def self.fields_put_params_properties
    %i(
      cmmDisplayName
      contact
      domainName
      hostname
      location
      userDescription
    )
  end

  def self.field_put_params_policy
    %i(
      securityPolicy
    )
  end

  def self.field_put_params_led
    %i(
      leds
    )
  end

  def self.field_put_params_cmm
    %i(
      cmmFailover
    )
  end

  def self.field_put_params_tls
    %i(
      nist
      tlsVersion
    )
  end

  def self.field_put_params_encapsulation_mode
    %i(
      encapsulationMode
    )
  end

end
