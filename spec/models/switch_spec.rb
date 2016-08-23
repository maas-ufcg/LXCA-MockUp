require 'rails_helper'

RSpec.describe Switch, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "Model validations" do
    before :each do
      @switch = build :switch
      @switch_missing_uuid = build :inv_switch_missing_uuid
      @switch_different_id_and_uuid = build :inv_switch_different_id_and_uuid
      @switch_missing_property = build :inv_switch_missing_property

      #Testing properties values that have a predefined list of values.
      @switch_with_invalid_accessState = build :inv_switch_invalid_accessState
      @switch_with_invalid_backedBy = build :inv_switch_invalid_backedBy
      @switch_with_invalid_cmmHealthState =  build :inv_switch_invalid_cmmHealthState
      @switch_with_invalid_excludedHealthState = build :inv_switch_invalid_excludedHealthState

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

    it "is invalid if accessState is not in a predefined list" do
        expect(@switch_with_invalid_accessState).to_not be_valid(Switch)
    end

    it "is invalid if backedBy is not in a predefined list" do
        expect(@switch_with_invalid_backedBy).to_not be_valid(Switch)
    end


    it "is invalid if cmmHealthState is not in a predefined list" do
        expect(@switch_with_invalid_cmmHealthState).to_not be_valid(Switch)
    end


    it "is invalid if excludedHealthState is not in a predefined list" do
        expect(@switch_with_invalid_excludedHealthState).to_not be_valid(Switch)
    end

  end

end
