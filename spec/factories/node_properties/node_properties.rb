require 'securerandom'

FactoryGirl.define do

  factory :node_properties, class: Hash do
    accessState { %w(Online Offline Partial Pending Unknown).sample }
    activationKeys do
      (0..Random.rand(0..10)).map do |key|
        {
          description: Faker::Lorem.sentence,
          keyExpirationDate: Faker::Date.between(Date.today, 5.year.from_now),
          keyFeatureType: Faker::Number.number(3),
          keyIdentiferList: (0..Random.rand(0..10)).map do |identifier|
            {
              keyIdentifier: Faker::Lorem.characters(15),
              keyIdentifierType: %w(ASIC MAC MT UNKNOWN).sample
            }
          end,
          keyStatus: %w(UNKNOWN OTHER VALID INVALID INPROCESS EXPIRED LIMIT_REACHED NEED_VALID_ELSEWHERE KEY_NOT_FOUND).sample,
          keyUseCount: Faker::Number.number(10),
          keyUseLimit: Faker::Number.number(20),
          uuid: Faker::Lorem.characters(15)
        }
      end
    end
    addinCardSlots {Faker::Number.number(Random.rand(0..20))}
    addinCards do
      (0..Random.rand(0..10)).map do |card|
        {
          FRU: "#{Faker::Number.number(Random.rand(0..10))}",
          firmware: (0..Random.rand(0..10)).map do |firm|
            {
              build: Faker::Lorem.characters(15),
              classifications: (0..Random.rand(0..50)).map do |type|
                Faker::Number.number(200)
              end,
              date: Faker::Date.between(5.year.ago, Date.today),
              name: Faker::Hacker.noun,
              revision: "#{Faker::Number.number(10)}",
              role: %w(Primary Backup Temporary Permanent).sample,
              softwareID: "#{Faker::Number.number(10)}",
              status: %w(Active Inactive),
              type: %w(UEFI MP DSA).sample,
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
            portType: %w(ATM ETHERNET FC FDDI FRAMERELAY IB OTHER TOKENRING UNKNOWN).sample,
            portNumber: "#{Faker::Number.number(5)}",
            logicalPorts: (0..Random.rand(0..10)).map do |type|
              {
                portType: %w(ATM BLUETOOTH ETHERNET FC FDDI FRAMERELAY IB INFRARED OTHER TOKENRING UNKNOWN WIRELESSLAN),
                portNumber: "#{Faker::Number.number(5)}",
                addresses: Faker::Internet.ip_v4_address,
                vnicMode: "#{Faker::Boolean.boolean}"
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
    arch { %w(ia64 ppc ppc64 x86 x86_64 Unknown).sample }
    backedBy { %w(real demo proxy).sample }
    bladeState { "#{Random.rand(0..17)}" }
    bootMode do
      {
        currentValue: Faker::Lorem.word,
        possibleValues: (0..Random.rand(0..10)).map do |mode|
          Faker::Lorem.word
        end
      }
    end

  end
  initialize_with { attributes }
end
