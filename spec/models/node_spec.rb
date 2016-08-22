require 'rails_helper'

RSpec.describe Node, type: :model do

  describe "Database Data Validation" do

    context "Invalid accessState Attribute Value" do
      before :each do
        @invalid_node = build :invalid_access_state_node
        @valid_node = build :valid_access_state_node
      end

      it "A Generated Value is Invalid to the accessState Attribute" do
        expect(@invalid_node).to_not be_valid(Node)
      end

      it "A Value is Valid to the accessState Attribute" do
        expect(@valid_node).to be_valid(Node)
      end
    end


    context "Invalid keyIdentifierType Attribute Value" do
      before :each do
        @invalid_node = build :invalid_key_identifier_type
        @valid_node = build :valid_key_identifier_type
      end

      it "A Generated Value is invalid to the keyIdentifierType Attribute" do
        expect(@invalid_node).to_not be_valid(Node)
      end

      it "A Value is Valid to the keyIdentifierType Attribute" do
        expect(@valid_node).to be_valid(Node)
      end
    end

  end
end
