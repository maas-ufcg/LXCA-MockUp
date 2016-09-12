# require 'rails_helper'
#
# RSpec.describe Node, type: :model do
#   describe "Database Data Validation: " do
#     context "Validation for saving new nodes: " do
#       before :each do
#         @valid_node = build :node
#       end
#
#       it "a valid node should be built" do
#         expect(@valid_node).to be_valid(Node)
#       end
#
#       it "saving a new node should change the number of elements on DB" do
#         expect {@valid_node.save}.to change {Node.count}.by 1
#       end
#
#       it "node._id must be equal to node.properties[:uuid]" do
#         expect(@valid_node._id).to eq(@valid_node.properties[:uuid])
#       end
#     end
#   end
# end
