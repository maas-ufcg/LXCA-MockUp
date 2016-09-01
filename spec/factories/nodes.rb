FactoryGirl.define do
  factory :node, aliases: [:valid_node] do
    properties { FactoryGirl.build(:node_properties) }

    after :build do |node|
      node._id = node.properties[:uuid]
    end
  end

  NodesHelper::required_fields.each do |field|
    factory :"no_#{field}_node", class: Node do

      properties { FactoryGirl.build(:node_properties) }

      after :build  do |node|
        node._id = node.properties[:uuid]
        node.properties.delete(field)
      end
    end

    factory :"nil_#{field}_node", class: Node do
      after :build  do |node|
        node._id = node.properties[:uuid]
        node.properties[field] = nil
      end

      properties { FactoryGirl.build(:node_properties) }
    end

    factory :"empty_string_#{field}_node", class: Node do
      after :build do |node|
        node._id = node.properties[:uuid]
        node.properties[field] = ""
      end

      properties { FactoryGirl.build(:node_properties) }
    end

  end
end
