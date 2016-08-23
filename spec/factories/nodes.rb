FactoryGirl.define do

  factory :invalid_access_state_node, class: Node do
    _id {Faker::Number.number(2).to_s}
    properties {{accessState: Faker::Lorem.characters(5)}}
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

end
