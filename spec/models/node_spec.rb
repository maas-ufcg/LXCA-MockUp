require 'rails_helper'

RSpec.describe Node, type: :model do
  describe "Database Data Validation: " do


    context "Validation for saving new nodes: " do
      before :each do
        @valid_node = build :node
      end

      it "a valid node should be built" do
        expect(@valid_node).to be_valid(Node)
      end

      it "saving a new node should change the number of elements on DB" do
        expect {@valid_node.save}.to change {Node.count}.by 1
      end

      it "node._id must be equal to node.properties[:uuid]" do
        expect(@valid_node._id).to eq(@valid_node.properties[:uuid])
      end

      NodesHelper::required_fields.each do |field|
        it "expect field #{field} neither can't be nil nor empty string" do
          expect(@valid_node.properties[field]).to_not eq(nil)
          expect(@valid_node.properties[field]).to_not eq("")
        end
      end

    end

    NodesHelper::required_fields.each do |field|
      context "Factory :no_#{field}_node" do
        before :each do
          @node = build :"no_#{field}_node"
        end

        it ":no_#{field}_node factory should not build an invalid object" do
          expect(@node).to_not be_valid(Node)
        end

        it "saving node without #{field} should not change the number of elements in DB" do
          expect {@node.save}.to change {Node.count}.by 0
        end

      end

      context "Factory :nil_#{field}_node" do
        before :each do
          @node = build :"no_#{field}_node"
        end

        it ":no_#{field}_node factory should not build an invalid object" do
          expect(@node).to_not be_valid(Node)
        end

        it "saving fan without #{field} should not change the number of elements in DB" do
          expect {@node.save}.to change {Node.count}.by 0
        end

      end

      context "Factory :empty_string_#{field}_node" do
        before :each do
          @node = build :"empty_string_#{field}_node"
        end

        it ":empty_string_#{field}_node should not build an invalid object" do
          expect(@node).to_not be_valid(Node)
        end

        it "saving node without #{field} should not change the number of elements in DB" do
          expect {@node.save}.to change {Node.count}.by 0
        end

      end
      
    end
  end
end
