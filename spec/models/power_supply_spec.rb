# require 'rails_helper'
#
# RSpec.describe PowerSupply, type: :model do
#
#
#   describe "Model validations:" do
#     context "The power supply" do
#       before :each do
#         @valid_power_supply = build :power_supply
#       end
#
#       it "is consistent." do
#         expect(@valid_power_supply).to be_valid(PowerSupply)
#       end
#
#       it "can be save." do
#         expect{ @valid_power_supply.save }.to change {PowerSupply.count}.by 1
#       end
#
#       it "power_supply._id show be equal to power_supply.properties[:uuid]" do
#         expect(@valid_power_supply._id).to eq(@valid_power_supply.properties[:uuid])
#       end
#       PowerSuppliesHelper::required_fields.each do |key|
#         it "expect field #{key} not not be nil or empty string" do
#           expect(@valid_power_supply.properties[key]).to_not eq(nil)
#           expect(@valid_power_supply.properties[key]).to_not eq("")
#         end
#       end
#     end
#
#     PowerSuppliesHelper::required_fields.each do |key|
#       context "Factory :no_#{key}_power_supply" do
#         before :each do
#           @power_supply = build :"no_#{key}_power_supply"
#         end
#
#         it ":no_#{key}_power_supply factory should build an invalid object." do
#           expect(@power_supply).to_not be_valid(PowerSupply)
#         end
#
#         it "should not save power_supply missing #{key}, the number of elements in BD should not change." do
#           expect{@power_supply.save}.to change{PowerSupply.count}.by 0
#         end
#
#       end
#       context "nil_#{key}_power_supply" do
#         before :each do
#           @power_supply = build :"nil_#{key}_power_supply"
#         end
#         it ":nil_#{key}_power_supply factory should build an invalid object" do
#           expect(@power_supply).to_not be_valid(PowerSupply)
#         end
#         it "saving power_supply without #{key} should not change the number of elements in DB" do
#           expect {@power_supply.save}.to change {PowerSupply.count}.by 0
#         end
#       end
#
#       context "Factory :empty_string_#{key}_power_supply" do
#         before :each do
#           @power_supply = build :"empty_string_#{key}_power_supply"
#         end
#
#         it ":empty_string_#{key}_power_supply factory should build an invalid object" do
#           expect(@power_supply).to_not be_valid(PowerSupply)
#         end
#
#         it "saving power_supply without #{key} should not change the number of elements in DB" do
#           expect {@power_supply.save}.to change {PowerSupply.count}.by 0
#         end
#       end
#     end
#
#   end
# end
