# require 'rails_helper'
#
# RSpec.describe Node, type: :model do
#   describe "Database Data Validation: " do
#
#     NodesHelper::required_fields.each do |field|
#       context "Factory :no_#{field}_node" do
#         before :each do
#           @node = build :"no_#{field}_node"
#         end
#
#         it ":no_#{field}_node factory should not build an invalid object" do
#           expect(@node).to_not be_valid(Node)
#         end
#
#         it "saving node without #{field} should not change the number of elements in DB" do
#           expect {@node.save}.to change {Node.count}.by 0
#         end
#
#       end
#     end
#   end
# end
