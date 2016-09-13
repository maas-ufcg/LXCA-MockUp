require 'securerandom'

FactoryGirl.define do
  factory :scalable_complex_properties, class: Hash do
    after :build do |scalable_complex_properties|
      scalable_complex_properties[:uri] = "/#{scalable_complex_properties[:uuid]}"
    end
    #location []
    nodeCount { Random.rand 2**61 }
    partition do
      (0..(Random.rand 10)).map do |node|
        {
          nodes: "",
          partitionID: "#{Random.rand 1...1000}" ,
          uuid:  SecureRandom.uuid
        }
      end
    end
    partitionCount { Random.rand 2**61 }
    uuid { SecureRandom.uuid }

    initialize_with { attributes }
  end
end
