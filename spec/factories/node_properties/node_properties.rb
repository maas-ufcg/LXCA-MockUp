require 'securerandom'
require 'faker'

FactoryGirl.define do
  ipv4_types = %w(INUSE CONFIGURED ALIAS UNKNOWN)
  led_locations = ["Front panel", "Lightpath Card", "Planar", "FRU", "Rear Panel", "Unknown"]
  led_states = %w(Off On Blinking Unknown)
  nist_current_values = %w(Unknown Compatibility Nist_810_131A_Strict Nist_810_131A_Custom)
  led_colors = %w(Red Amber Yellow Green Blue Unknown)

  factory :node_properties, class: Hash do
    accessState { NodesHelper::possible_values_per_field[:accessState].sample }
    activationKeys do
      (1..Random.rand(1..10)).map do |key|
        {
          description: Faker::Lorem.sentence,
          keyExpirationDate: Faker::Date.between(Date.today, 5.year.from_now),
          keyFeatureType: Faker::Number.number(3),
          keyIdentiferList: (1..Random.rand(1..10)).map do |identifier|
            {
              keyIdentifier: Faker::Lorem.characters(15),
              keyIdentifierType: NodesHelper::possible_values_per_sub_field[:keyIdentifierType].sample
            }
          end,
          keyStatus: NodesHelper::possible_values_per_sub_field[:keyStatus].sample,
          keyUseCount: Faker::Number.number(10),
          keyUseLimit: Faker::Number.number(20),
          uuid: SecureRandom.uuid
        }
      end
    end
    addinCardSlots {Faker::Number.number(Random.rand(1..20))}
    addinCards do
      (1..Random.rand(1..10)).map do |card|
        {
          FRU: "#{Faker::Number.number(Random.rand(1..10))}",
          firmware: (1..Random.rand(1..10)).map do |firm|
            {
              build: Faker::Lorem.characters(15),
              classifications: (1..Random.rand(1..5)).map do |type|
                Faker::Number.number(5)
              end,
              date: Faker::Date.between(5.year.ago, Date.today),
              name: Faker::Hacker.noun,
              revision: "#{Faker::Number.number(10)}",
              role: NodesHelper::possible_values_per_sub_field[:role].sample,
              softwareID: "#{Faker::Number.number(10)}",
              status: NodesHelper::possible_values_per_sub_field[:firmware_status].sample,
              type: NodesHelper::possible_values_per_sub_field[:firmware_types].sample,
              version: Faker::App.version
            }
          end,
          fodUniqueID: "#{Faker::Number.number(5)}",
          fruSerialNumber: Faker::Lorem.characters(10),
          isAddOnCard: "#{Faker::Boolean.boolean}",
          isAgentless: "#{Faker::Boolean.boolean}",
          manufacturer: Faker::Lorem.characters(5),
          name: Faker::Lorem.sentence,
          partNumber: "#{Faker::Number.number(10)}",
          pciBusNumber: "#{Faker::Number.number(10)}",
          pciDeviceNumber: "#{Faker::Number.number(10)}",
          pciFunctionNumber: "#{Faker::Number.number(10)}",
          pciRevision: "#{Faker::Number.number(10)}",
          pciSubID: "#{Faker::Number.number(5)}",
          pciSubVendorID: "#{Faker::Number.number(5)}",
          portInfo: {
            portType: NodesHelper::possible_values_per_sub_field[:port_few_types].sample,
            portNumber: "#{Faker::Number.number(5)}",
            logicalPorts: (1..Random.rand(1..10)).map do |type|
              {
                portType: NodesHelper::possible_values_per_sub_field[:port_types].sample,
                portNumber: "#{Faker::Number.number(5)}",
                addresses: Faker::Internet.ip_v4_address,
                e: "#{Faker::Boolean.boolean}"
              }
            end,
            peerBay: "#{Faker::Number.number(5)}"
          },
          posID: "#{Faker::Number.number(10)}",
          productName: Faker::Lorem.word,
          slotName: Faker::Lorem.word,
          slotNumber: "#{Faker::Number.number(5)}",
          slotSupportsHotPlug: "#{Faker::Boolean.boolean}",
          vpdID: "#{Faker::Number.number(10)}"
        }
      end
    end
    arch { NodesHelper::possible_values_per_field[:arch].sample }
    backedBy { NodesHelper::possible_values_per_field[:backedBy].sample }
    bladeState { "#{Random.rand(1..17)}" }
    bootMode do
      {
        currentValue: Faker::Lorem.word,
        possibleValues: (1..Random.rand(1..10)).map do |mode|
          Faker::Lorem.word
        end
      }
    end
    bootOrder do
      {
        uri: Faker::Internet.url,
        bootOrderList: (1..Random.rand(1..5)).map do |attribute|
          {
            bootType: NodesHelper::possible_values_per_sub_field[:bootType].sample,
            currentBootOrderDevices: (1..Random.rand(1..5)).map do |device|
              Faker::Lorem.word
            end,
            possibleBootOrderDevices: (1..Random.rand(1..5)).map do |device|
              Faker::Lorem.word
            end
          }
        end
      }
    end
    canisters do
      (1..Random.rand(1..5)).map do |device|
        "#{Faker::Number.number(5)}"
      end
    end
    canisterSlots {Faker::Number.number(5)}
    cmmDisplayName {Faker::Lorem.word}
    cmmHealthState { NodesHelper::possible_values_per_field[:cmmHealthState].sample}
    complexID {Faker::Number.number(5)}
    contact ""# TODO: Not documented
    dataHandle {Faker::Number.number(8)}
    description {Faker::Lorem.sentence}
    dnsHostnames {
      (1..Random.rand(1..10)).map do |name|
        Faker::Internet.domain_name
      end
    }
    domainName {Faker::Internet.domain_name}
    driveBays {Faker::Number.number(8)}
    drives {
      (1..Random.rand(1..10)).map do |drive|
        {
          bay: Faker::Number.number(8),
          capacity: Faker::Number.number(8),
          interfaceType: Faker::Lorem.word,
          mediaType: Faker::Lorem.word,
          raidPresence: NodesHelper::possible_values_per_sub_field[:raidPresence].sample,
          speed: Faker::Lorem.characters(10),
          state: %w(active stopped transitioning).sample
        }
      end
    }
    embeddedHypervisorPresence {"#{Faker::Boolean.boolean}"}
    encapsulation do
      {
        encapsulationMode: NodesHelper::possible_values_per_sub_field[:encapsulationMode].sample,
        nonBlockedIpAddressList: (1..Random.rand(1..10)).map do |ip|
          Faker::Internet.ip_v4_address
        end
      }
    end
    errorFields do
      (1..Random.rand(1..10)).map do |error|
        {
          label: "", # TODO: Not documented,
          errorCode: NodesHelper::possible_values_per_sub_field[:errorCode].sample
        }
      end
    end
    excludedHealthState {NodesHelper::possible_values_per_sub_field[:health_states].sample}
    expansionCardSlots {Faker::Number.number(5)}
    expansionCards do
      (1..Random.rand(1..10)).map do |card|
        {
          fodUniqueID: "#{Faker::Number.number(10)}",
          isAddOnCard: "#{Faker::Boolean.boolean}",
          isAgentless: "#{Faker::Boolean.boolean}",
          name: Faker::Lorem.word,
          pciBusNumber: "#{Faker::Number.number(15)}",
          pciDeviceNumber: "#{Faker::Number.number(15)}",
          pciFunctionNumber: "#{Faker::Number.number(15)}",
          pciSubID: "#{Faker::Number.number(15)}",
          pciSubVendorID: "#{Faker::Number.number(15)}",
          portInfo: {
              portType: NodesHelper::possible_values_per_sub_field[:port_few_types].sample,
              portNumber: Faker::Number.number(4),
              logicalPorts: (1..Random.rand(1..10)).map do |port|
                {
                  portType: NodesHelper::possible_values_per_sub_field[:port_types].sample,
                  portNumber: Faker::Number.number(4),
                  addresses: Faker::Lorem.characters(10).upcase,
                  e: "#{Faker::Boolean.boolean}"
                }
              end,
              peerBay: Faker::Number.number(4)
            },
          posID: "#{Faker::Number.number(15)}",
          vpdID: "#{Faker::Number.number(15)}"
        }
      end
    end
    expansionProductType { NodesHelper::possible_values_per_field[:expansionProductType].sample }
    expansionProducts { NodesHelper::possible_values_per_field[:expansionProducts].sample }
    expansionProductSlots {Faker::Number.number(4)}
    firmware do
      (1..Random.rand(1..10)).map do |firmware|
        {
          build: Faker::Lorem.characters(5).upcase,
          date: Faker::Date.between(2.years.ago, Date.today),
          name: Faker::Name.first_name,
          role: NodesHelper::possible_values_per_sub_field[:firmware_roles].sample,
          status: NodesHelper::possible_values_per_sub_field[:firmware_status].sample,
          type: NodesHelper::possible_values_per_sub_field[:firmware_types].sample,
          version: Faker::App.version
        }
      end
    end
    flashStorage do
      (1..Random.rand(1..10)).map do |flash|
        {
          defaultBlockSize: Faker::Number.number(4),
          description: Faker::Lorem.sentence,
          serialNumber: Faker::Lorem.characters(5).upcase,
          firmware: {
            build: Faker::Lorem.characters(5).upcase,
            classifications: (1..Random.rand(1..10)).map do |code|
              Faker::Number.number(Random.rand(1..10))
            end,
            date: Faker::Date.between(2.years.ago, Date.today),
            name: Faker::Name.first_name,
            role: NodesHelper::possible_values_per_sub_field[:firmware_roles].sample,
            softwareID: Faker::Lorem.characters(5).upcase,
            status: NodesHelper::possible_values_per_sub_field[:firmware_status].sample,
            type: NodesHelper::possible_values_per_sub_field[:firmware_types].sample,
            version: Faker::App.version
          },
          manufacturer: "IBM",
          maxMediaSize: Faker::Number.number(10),
          name: Faker::Lorem.sentence,
          partNumber: Faker::Lorem.characters(5).upcase,
          slotNumber: Faker::Number.number(Random.rand(1..4)),
          uuid: SecureRandom.uuid
        }
      end
    end
    FRU {Faker::Lorem.characters(5).upcase}
    fruSerialNumber {"#{Faker::Number.number(7)}"}
    hasOS {%w(true false).sample}
    height {Faker::Number.number(7)}
    hostMacAddresses {Faker::Internet.mac_address}
    hostname {Faker::Lorem.characters(8)}
    ipInterfaces do
      (1..Random.rand(1..10)).map do |address|
        {
          IPv4DHCPmode: NodesHelper::possible_values_per_sub_field[:IPv4DHCPmode].sample,
          IPv4assignments: (1..Random.rand(1..10)).map do |ipv4|
            {
              address: Faker::Internet.ip_v4_address,
              gateway: Faker::Internet.ip_v4_address,
              id: Faker::Number.number(2),
              subnet: "255.255.241.1",
              type: ipv4_types.sample
            }
          end,
          IPv4enabled: Faker::Boolean.boolean,
          IPv6DHCPenabled: Faker::Boolean.boolean,
          IPv6assignments: (1..Random.rand(1..10)).map do |assign|
            {
              address: Faker::Internet.ip_v6_address,
              gateway: Faker::Internet.ip_v6_address,
              id: Faker::Number.number(2),
              prefix: Faker::Number.number(2),
              scope: %w(Global LinkLocal Unknown).sample,
              source: %w(DHCP Statelesss Static Other Unknown).sample,
              type: ipv4_types.sample
            }
          end,
          IPv6enabled: Faker::Boolean.boolean,
          IPv6statelessEnabled: Faker::Boolean.boolean,
          IPv6staticEnabled: Faker::Boolean.boolean,
          label: Faker::Lorem.word,
          name: Faker::Lorem.word
        }
      end
    end
    ipv4Addresses do
      (1..Random.rand(1..10)).map do |addr|
        Faker::Internet.ip_v4_address
      end
    end
    ipv6Addresses do
      (1..Random.rand(1..10)).map do |addr|
        Faker::Internet.ip_v6_address
      end
    end
    isConnectionTrusted {Faker::Boolean.boolean}
    isITME {Faker::Boolean.boolean}
    isRemotePresenceEnabled {Faker::Boolean.boolean}
    isScalable {Faker::Boolean.boolean}
    lanOverUsb {%w(enabled disabled).sample}
    leds do
      (1..Random.rand(1..10)).map do |led|
        {
          color: led_colors.sample,
          location: led_locations.sample,
          name: Faker::Lorem.word,
          state: led_states.sample
        }
      end
    end
    location do
      {
        location: "",
        lowestRackUnit: Faker::Number.number(2),
        rack: "",
        room: ""
      }
    end
    logicalID {Faker::Number.number(3)}
    macAddress {Faker::Internet.mac_address}
    machineType {"#{Faker::Number.number(5)}"}
    manufacturer {"IBM(WIST)"}
    manufacturerID {"IBM(WIST)"}
    memoryModules do
      (1..Random.rand(1..10)).map do |mmodule|
        {
          capacity: Faker::Number.number(10),
          displayName: Faker::Lorem.word,
          manufacturer: Faker::Lorem.word,
          model: Faker::Lorem.word,
          partNumber: Faker::Lorem.characters(10).upcase,
          serialNumber: Faker::Lorem.characters(7).upcase,
          slot: Faker::Number.number(2),
          speed: Faker::Number.number(4),
          type: Faker::Lorem.word,
          voltage: Faker::Number.number(3)
        }
      end
    end
    memorySlots {Faker::Number.number(2)}
    mgmtProcIPaddress {Faker::Internet.ip_v4_address}
    model {Faker::Lorem.characters(3).upcase}
    name {["Host name", "IP address", "Component name", "Serial number", "UUID"].sample}
    nist do
      {
        currentValue: nist_current_values.sample,
        possibleValues: nist_current_values
      }
    end
    onboardPciDevices do
      (1..Random.rand(1..10)).map do |device|
        {
        firmware: (1..Random.rand(1..10)).map do |firm|
          {
            build: "#{Faker::Number.number(2)}",
            classifications: (1..Random.rand(1..10)).map do |clas|
              Faker::Number.number(2)
            end,
            date: "",
            name: Faker::Lorem.word,
            revision: "#{Faker::Number.number(2)}",
            role: NodesHelper::possible_values_per_sub_field[:firmware_roles].sample,
            softwareID: Faker::Number.number(5),
            status: NodesHelper::possible_values_per_sub_field[:firmware_status].sample,
            type: NodesHelper::possible_values_per_sub_field[:firmware_types].sample,
            version: Faker::Number.number(2)
          }
        end,
        fodUniqueID: Faker::Lorem.characters(12).upcase,
        isAddOnCard: Faker::Boolean.boolean,
        isAgentless: Faker::Boolean.boolean,
        name: Faker::Lorem.word,
        pciBusNumber: "#{Faker::Number.number(2)}",
        pciDeviceNumber: "#{Faker::Number.number(1)}",
        pciFunctionNumber: "#{Faker::Number.number(1)}",
        pciRevision: "#{Faker::Number.number(1)}",
        pciSubID: Faker::Lorem.characters(3),
        pciSubVendorID: "#{Faker::Number.number(4)}",
        portInfo: {
          portType: NodesHelper::possible_values_per_sub_field[:port_few_types].sample,
          portNumber: Faker::Number.number(4),
          logicalPorts: (1..Random.rand(1..10)).map do |port|
            {
              portType: NodesHelper::possible_values_per_sub_field[:port_types].sample,
              portNumber: Faker::Number.number(4),
              addresses: Faker::Lorem.characters(8).upcase,
              e: Faker::Boolean.boolean
            }
          end,
          peerBay: Faker::Number.number(4)
        },
        posID: Faker::Number.number(4),
        vpdID: Faker::Lorem.characters(4)
      }
      end
    end
    overallHealthState {NodesHelper::possible_values_per_sub_field[:health_states].sample}
    parent do
      {
        uuid: SecureRandom.uuid,
        uri: Faker::Internet.url
      }
    end
    parentComplexID {""}
    parentPartitionUUID {""}
    partNumber {Faker::Lorem.characters(Random.rand(1..8)).upcase}
    partitionID {Faker::Number.number(1)}
    partitionEnabled {Faker::Boolean.boolean}
    pciCapabilities do
      (1..Random.rand(1..10)).map do |cap|
          Faker::Lorem.word
      end
    end
    pciDevices do
      (1..Random.rand(1..10)).map do |device|
        {
          FRU: Faker::Lorem.characters(Random.rand(1..4)).upcase,
          firmware: (1..Random.rand(1..10)).map do |firm|
            {
              build: Faker::Lorem.characters(Random.rand(1..4)).upcase,
              classifications: (1..Random.rand(1..10)).map do |clas|
                Faker::Number.number(4)
              end,
              date: Faker::Date.between(2.years.ago, Date.today),
              name: Faker::Lorem.word,
              revision: "#{Faker::Number.number(1)}",
              role: NodesHelper::possible_values_per_sub_field[:firmware_roles].sample,
              softwareID: "#{Faker::Number.number(8)}",
              status: NodesHelper::possible_values_per_sub_field[:firmware_status].sample,
              type: NodesHelper::possible_values_per_sub_field[:firmware_types].sample,
              version: "#{Faker::Number.number(8)}"
            }
          end,
          fodUniqueID: Faker::Lorem.characters(Random.rand(1..10)).upcase,
          fruSerialNumber: Faker::Lorem.characters(Random.rand(1..10)).upcase,
          isAddOnCard: Faker::Boolean.boolean,
          isAgentless: Faker::Boolean.boolean,
          manufacturer: Faker::Company.name,
          name: Faker::Lorem.sentence,
          partNumber: Faker::Lorem.characters(8).upcase,
          pciBusNumber: "#{Faker::Number.number(Random.rand(1..2))}",
          pciDeviceNumber: "#{Faker::Number.number(Random.rand(1..2))}",
          pciFunctionNumber: "#{Faker::Number.number(Random.rand(1..2))}",
          pciRevision: "#{Faker::Number.number(Random.rand(1..2))}",
          pciSubID: "#{Faker::Number.number(3)}",
          pciSubVendorID: "#{Faker::Number.number(4)}",
          portInfo:
            {
              portType: NodesHelper::possible_values_per_sub_field[:port_few_types].sample,
              portNumber: Faker::Number.number(4),
              logicalPorts: (1..Random.rand(1..10)).map do |port|
                {
                  portType: NodesHelper::possible_values_per_sub_field[:port_types].sample,
                  portNumber: Faker::Number.number(4),
                  addresses: Faker::Lorem.characters(Random.rand(8..10)).upcase,
                  vnicMode: Faker::Boolean.boolean
                }
              end,
              peerBay: Faker::Number.number(4)
            },
          posID: "#{Faker::Number.number(10)}",
          productName: Faker::Lorem.word,
          slotName: Faker::Lorem.word,
          slotNumber: Faker::Number.number(1),
          slotSupportsHotPlug: Faker::Boolean.boolean,
          vpdID: "#{Faker::Number.number(10)}"
        }
      end
    end
    pciExpressCards do
      (1..Random.rand(1..10)).map do |port|
        {
          fodUniqueID: Faker::Lorem.characters(Random.rand(1..10)).upcase,
          isAddOnCard: Faker::Boolean.boolean,
          isAgentless: Faker::Boolean.boolean,
          name: Faker::Lorem.sentence,
          pciBusNumber:"#{Faker::Number.number(Random.rand(1..2))}",
          pciDeviceNumber: "#{Faker::Number.number(Random.rand(1..2))}",
          pciFunctionNumber: "#{Faker::Number.number(Random.rand(1..2))}",
          pciSubID: "#{Faker::Number.number(3)}",
          pciSubVendorID: "#{Faker::Number.number(4)}",
          portInfo: {
            portType: NodesHelper::possible_values_per_sub_field[:port_few_types].sample,
            portNumber: Faker::Number.number(4),
            logicalPorts: (1..Random.rand(1..10)).map do |port|
              {
                portType: NodesHelper::possible_values_per_sub_field[:port_types].sample,
                portNumber: Faker::Number.number(4),
                addresses: Faker::Lorem.characters(Random.rand(8..10)).upcase,
                vnicMode: Faker::Boolean.boolean
              }
            end,
            peerBay: Faker::Number.number(4)
          },
          posID: "#{Faker::Number.number(10)}",
          vpdID: "#{Faker::Number.number(10)}"
        }
      end
    end
    pciExpressCardSlots {Faker::Number.number(4)}
    physicalID {Faker::Number.number(4)}
    ports do
      (1..Random.rand(1..10)).map do |port|
        {
          ioModuleBay: Faker::Number.number(1),
          portNumber: Faker::Number.number(1)
        }
      end
    end
    posID {"#{Faker::Number.number(10)}"}
    powerAllocation do
      {
        maximumAllocatedPower: Faker::Number.number(3),
        minimumAllocatedPower: Faker::Number.number(2)
      }
    end
    powerCappingPolicy do
      {
        cappingACorDCMode: %w(AC DC Unknown).sample,
        cappingPolicy: %w(OFF STATIC UNKNOWN).sample,
        currentPowerCap: Faker::Number.number(1),
        maxPowerCap: Faker::Number.number(6),
        maximumPowerCappingHotPlugLevel: Faker::Number.number(6),
        minPowerCap: Faker::Number.number(5),
        minimumHardCapLevel: Faker::Number.number(6),
        minimumPowerCappingHotPlugLevel: Faker::Number.number(6),
        powerCappingAllocUnit: "watts*10^-3"
      }
    end
    powerStatus {[1, 5, 8, 18].sample}
    powerSupplies do
      (1..Random.rand(1..10)).map do |supplie|
        {
          cmmDisplayName: Faker::Lorem.word,
          dataHandle: Faker::Number.number(13),
          description: Faker::Lorem.sentence,
          firmware: (1..Random.rand(1..10)).map do |firm|
            {
              build: Faker::Lorem.characters(Random.rand(8..10)).upcase,
              date: Faker::Date.between(2.years.ago, Date.today),
              name: Faker::Company.name,
              role: NodesHelper::possible_values_per_sub_field[:firmware_roles].sample,
              status: NodesHelper::possible_values_per_sub_field[:firmware_status].sample,
              type: NodesHelper::possible_values_per_sub_field[:firmware_types].sample,
              version: Faker::App.version
            }
          end,
          FRU: Faker::Lorem.characters(5).upcase,
          fruSerialNumber: Faker::Lorem.characters(10),
          hardwareRevision: "",
          healthState: NodesHelper::possible_values_per_sub_field[:health_states].sample,
          inputVoltageIsAC: Faker::Boolean.boolean,
          inputVoltageMax: Faker::Number.number(1),
          inputVoltageMin: Faker::Number.number(1),
          leds: (1..Random.rand(1..10)).map do |led|
            {
              color: led_colors.sample,
              location: led_locations.sample,
              name: Faker::Lorem.word,
              state: led_states.sample
            }
          end,
          machineType: "#{Faker::Number.number(4)}",
          manufactureDate: "", # TODO: Not Documented
          manufacturer: Faker::Lorem.characters(5),
          manufacturerId: "IBM(WIST)",
          model: Faker::Lorem.characters(3).upcase,
          name: ["component name", "serial number", "UUID"].sample,
          partNumber: "#{Faker::Number.number(10)}",
          posID: "#{Faker::Number.number(10)}",
          powerAllocation: {
            totalInputPower: Faker::Number.number(Random.rand(1..6)),
            totalOutputPower: Faker::Number.number(Random.rand(1..6))
          },
          powerState: %w(Off On ShuttingDown Standby Hibernate Unknown).sample,
          productId: Faker::Lorem.characters(5).upcase,
          productName: "Lenovo System x3550 M5",
          serialNumber: Faker::Lorem.characters(8).upcase,
          slots: (1..Random.rand(1..10)).map do |slot|
            Faker::Number.number(1)
          end,
          type: "PowerSupply.",
          uri: Faker::Internet.url,
          userDescription: Faker::Lorem.sentence,
          uuid: "#{SecureRandom.uuid}",
          vpdID: "#{Faker::Number.number(10)}"
        }
      end
    end
    primary {Faker::Boolean.boolean}
    processorSlots {Faker::Number.number(Random.rand(1..2))}
    processors do
      (1..Random.rand(1..10)).map do |slot|
        {
          cores: Faker::Number.number(2),
          family: "INTEL_R_XEON_TM",
          displayName: Faker::Lorem.word,
          manufacturer: Faker::Lorem.word,
          productVersion: "Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz",
          slot: Faker::Number.number(1),
          speed: Faker::Number.decimal(1)
        }
      end
    end
    productID {Faker::Lorem.characters(5).upcase}
    productName {Faker::Lorem.word}
    raidSettings do
      (1..Random.rand(1..10)).map do |device|
        {
          description: Faker::Lorem.sentence,
          diskDrives: (1..Random.rand(1..10)).map do |drive|
            {
              FRU: "#{Faker::Number.number(Random.rand(1..10))}",
              bay: Faker::Number.number(8),
              blockSize: Faker::Number.number(3),
              description: Faker::Lorem.sentence,
              diskState: "System",
              healthState: NodesHelper::possible_values_per_sub_field[:health_states].sample,
              interfaceType: "SAS", # TODO: Not Documented
              manufacturer: "EMER", # TODO: Not Documented
              mediaType: "Rotational", # TODO: Not documented
              model: Faker::Lorem.characters(5).upcase,
              name: Faker::Hacker.noun,
              numberOfBlocks: Faker::Number.number(9),
              partNumber: Faker::Lorem.characters(7).upcase,
              serialNumber: Faker::Lorem.characters(8).upcase,
              uuid: SecureRandom.uuid
            }
          end,
          firmware: (1..Random.rand(1..10)).map do |firm|
            {
              # TODO: Not Documented
            }
          end,
          name: Faker::Hacker.noun,
          uuid: SecureRandom.uuid
        }
      end
    end
    secureBootMode do
      {
        currentValue: Faker::Lorem.word, # TODO: Not Documented
        possibleValues: (1..Random.rand(1..10)).map do |mode|
          Faker::Lorem.word
        end
      }
    end
    serialNumber {Faker::Lorem.characters(7).upcase}
    slots do
      (1..Random.rand(1..10)).map do |slot|
          Faker::Number.number(1)
      end
    end
    status do
      {
        message: %w(managed unmanaged).sample,
        name: %w(MANAGED UNMANAGED).sample
      }
    end
    subSlots do
      (1..Random.rand(1..10)).map do |slot|
          Faker::Number.number(1)
      end
    end
    subType {""} # TODO: Not Documented
    thinkServerFru do
      (1..Random.rand(1..10)).map do |fru|
        {
          deviceName: "", # TODO: Not Documented
          description: Faker::Lorem.sentence,
          manufatucturer: Faker::Company.name,
          manufatucturerDate: Faker::Date.between(Date.today, 5.year.from_now),
          serial: Faker::Lorem.characters(5).upcase,
          partNumber: Faker::Lorem.characters(5).upcase
        }
      end
    end
    tlsVersion do
      {
        currentValue: %w(Unknown SSL_30 TLS_10 TLS_11 TLS_12 TLS_12_Server_Client TLS_12_Server).sample,
        possibleValues: (1..Random.rand(1..10)).map do |value|
          Faker::Lorem.word
        end
      }
    end
    type { NodesHelper::possible_values_per_field[:type].sample }
    uri {Faker::Internet.url}
    userDescription {Faker::Lorem.sentence}
    uuid {"#{SecureRandom.uuid}"}
    vnicMode { NodesHelper::possible_values_per_field[:vnicMode].sample }
    vpdID {"#{Faker::Number.number(10)}"}

    initialize_with { attributes }

  end
end
