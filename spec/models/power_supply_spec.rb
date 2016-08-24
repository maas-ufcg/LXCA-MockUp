require 'rails_helper'

RSpec.describe PowerSupply, type: :model do

  describe "Model validation Power Supplies" do

    context "Power Supplies" do
      before :each do
        @invalid_node = build :invalid_cmm_health_state_power_supply
        @valid_node = build :valid_cmm_Health_State_power_supply
      end
      it "A Generated Value is Invalid to the cmmHealthState Attribute" do
          expect(@invalid_node).to_not be_valid(PowerSupply)
      end

      it "A Value is Valid to the cmmHealthState Attribute" do
          expect(@valid_node).to be_valid(PowerSupply)
      end
    end
  end

end
