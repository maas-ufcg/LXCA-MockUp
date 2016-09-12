# require 'rails_helper'
#
# RSpec.describe Node, type: :model do
#   describe "Database Data Validation: " do
#     context "Properties fields existence" do
#       before :each do
#         @valid_node = build :node
#       end
#
#       NodesHelper::required_fields.each do |field|
#         it "expect field #{field} neither can't be nil nor empty string" do
#           expect(@valid_node.properties[field]).to_not eq(nil)
#           expect(@valid_node.properties[field]).to_not eq("")
#         end
#       end
#     end
#   end
# end
