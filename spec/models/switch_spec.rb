require 'rails_helper'

RSpec.describe Switch, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "Model validations" do
    before :each do
      @switch = build :switch
      @switch_missing_uuid = build :inv_switch_missing_uuid
      @switch_different_id_and_uuid = build :inv_switch_different_id_and_uuid
      @switch_missing_property = build :inv_switch_missing_property
    end


    it "is invalid if has no uuid in properties" do
      expect(@switch_hasnt_uuid).to_not be_valid(Switch)
    end

    it "is invalid if _id is different from properties.uuid" do
      expect(@switch_different_id_and_uuid).to_not be_valid(Switch)
    end

    it "is invalid if some property is missing" do
      expect(@switch_missing_property).to_not be_valid(Switch)
    end

    it "a valid Switch can be saved" do
      expect(@switch).to be_valid(Switch)
    end




  end

end
