FactoryGirl.define do
  factory :scalable_complex_properties, class: Hash do
    location do
      {
        location => Faker::Space.planet,
        lowestRackUnit => (Random.rand 0..10).to_s + "RU",
        rack => Faker::Lorem.word,
        room => Faker::Lorem.word
      }
    end
    nodeCount = 4
    orphanNodes do
      2.map do |index|
        build :node
      end
    end
    partition = [
      [nodes do
        2.map do |index|
          build :node
        end
      end,
      partitionID = (Random.rand 0..10),
      uuid = SecureRandom.uuid]
    ]
    partitionCount = partition[1]
    uuid = partition[2]
  end
end
