module PowerSuppliesHelper

  def self.required_fields
    %i(
      cmmDisplayName cmmHealthState dataHandle description firmware FRU
      fruSerialNumber hardwareRevision inputVoltageIsAC inputVoltageMax
      inputVoltageMin leds manufacturer manufactureDate manufacturerID
      name parent partNumber posID powerAllocation powerState productID
      serialNumber slots type uri userDescription uuid vpdID
      )
  end

  # def self.type_fields
  #   {
  #     :cmmDisplayName => String,
  #     :cmmHealthState => String,
  #     :dataHandle => Long,
  #     :description => String,
  #     :firmware => Array,
  #     :FRU => String,
  #     :fruSerialNumber => String,
  #     :hardwareRevision => String,
  #     :inputVoltageIsAC => Boolean,
  #     :inputVoltageMax => Long,
  #     :inputVoltageMin => Long,
  #     :leds => Array,
  #     :manufacturer => String,
  #     :manufactureDate => String,
  #     :manufacturerID => String,
  #     :name => String,
  #     :parent => Hash,
  #     :partNumber => String,
  #     :posID => String,
  #     :powerAllocation => Hash,
  #     :powerState => String,
  #     :productID => String,
  #     :serialNumber => String,
  #     :slots => Integer,
  #     :type => String,
  #     :uri => String,
  #     :userDescription => String,
  #     :uuid => String,
  #     :vpdID => String
  #   }
  # end
end
