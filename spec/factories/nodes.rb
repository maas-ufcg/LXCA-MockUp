FactoryGirl.define do

  factory :node do
    properties { FactoryGirl.build :node_properties }

    after(:build) do |node_properties|
      node_properties = node_properties[:uuid]
    end
  end

  factory :invalid_access_state_node, class: Node do
    node_properties = FactoryGirl.build :node_properties
    _id {node_properties[:uuid]}
    properties {accessState Faker::Lorem.characters(10)}
  end

  factory :valid_access_state_node, class: Node do
    validValues = ["Online", "Offline", "Partial", "Pending", "Unknown"]

    _id {Faker::Number.number(2).to_s}
    properties {{accessState: validValues.sample}}
  end

  factory :invalid_key_identifier_type, class: Node do
    _id {Faker::Number.number(2).to_s}
    properties {activationKeys {keyIdentiferList {keyIdentifierType Faker::Lorem.characters(5)}}}
  end

  factory :valid_key_identifier_type, class: Node do
    validValues = ["Online", "Offline", "Partial", "Pending", "Unknown"]

    _id {Faker::Number.number(2).to_s}
    properties {activationKeys {keyIdentiferList {keyIdentifierType validValues.sample}}}
  end

  #
  # factory :inv_node_missing_uuid, class: Node do
  #   properties {FactoryGirl.build(:node_properties)}
  #
  #   after(:build) do |node_properties|
  #     node_properties._id =  node_properties[:uuid]
  #     node_properties.properties.delete(:uuid)
  #   end
  # end

  # NodesHelper::required_fields.each do |key|
  #
  #  factory :"no_#{key}_node", class: Node do
  #    after :build do |node_properties|
  #      node_properties._id = node_properties.properties[:uuid]
  #      node_properties.properties.delete(key)
  #    end
  #
  #    properties {FactoryGirl.build(:node_properties)}
  #  end

   #
  #  factory :"nil_#{key}_node_properties", class: Node do
  #    after :build do |node_properties|
  #      node_properties._id = node_properties.properties[:uuid]
  #      node_properties.properties[key] = nil
  #    end
   #
  #    properties {FactoryGirl.build(:node_properties)}
  #  end
   #
  #  factory :"empty_#{key}_node_properties", class: Node do
  #    after :build do |node_properties|
  #      node_properties._id = node_properties.properties[:uuid]
  #      node_properties.properties[key] = ""
  #    end
   #
  #    properties {FactoryGirl.build(:node_properties)}
  #  end
end
