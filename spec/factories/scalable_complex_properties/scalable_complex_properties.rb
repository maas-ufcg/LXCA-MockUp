FactoryGirl.define do
  factory :scalable_complex_properties, class: Hash do
    location = ""
    nodeCount = 4
    # orphanNodes do
    #   (1..2).map do |key|
    #     build :node
    #   end
    # end
    partition = {
        nodes: (1..2).map do |node| :node
        end,
        partitionID: 1,
        uuid: "C29379AA380E11E39DF3000AF7256714"
    }
    partitionCount = 1
    uuid = "C29379AA380E11E39DF3000AF7256714"
  end
end
