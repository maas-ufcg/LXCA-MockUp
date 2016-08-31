require 'rails_helper'

RSpec.describe Canister, type: :model do

  describe "Validity of Canister Model" do
    context "Factory :canister" do
      before :each do
        @valid_canister = build :canister
      end

      it ":canister factory should build a valid object" do
        expect(@valid_canister).to be_valid(Canister)
      end

      it "saving a new canister should change the number of elements in DB" do
        expect {@valid_canister.save}.to change {Canister.count}.by 1
      end

      it "canister._id show be equal to canister.properties[:uuid]" do
        expect(@valid_canister._id).to eq(@valid_canister.properties[:uuid])
      end

      CanistersHelper::required_fields.each do |field|
        it "expect field #{field} not not be nil or empty string" do
          expect(@valid_canister.properties[field]).to_not eq(nil)
          expect(@valid_canister.properties[field]).to_not eq("")
        end
      end
    end

    CanistersHelper::required_fields.each do |field|
      context "Factory :no_#{field}_canister" do
        before :each do
          @canister = build :"no_#{field}_canister"
        end

        it ":no_#{field}_canister factory should build an invalid object" do
          expect(@canister).to_not be_valid(Canister)
        end

        it "saving canister without #{field} should not change the number of elements in DB" do
          expect {@canister.save}.to change {Canister.count}.by 0
        end
      end

      context "Factory :nil_#{field}_canister" do
        before :each do
          @canister = build :"nil_#{field}_canister"
        end

        it ":nil_#{field}_canister factory should build an invalid object" do
          expect(@canister).to_not be_valid(Canister)
        end

        it "saving canister without #{field} should not change the number of elements in DB" do
          expect {@canister.save}.to change {Canister.count}.by 0
        end
      end

      context "Factory :empty_string_#{field}_canister" do
        before :each do
          @canister = build :"empty_string_#{field}_canister"
        end

        it ":empty_string_#{field}_canister factory should build an invalid object" do
          expect(@canister).to_not be_valid(Canister)
        end

        it "saving fan without #{field} should not change the number of elements in DB" do
          expect {@canister.save}.to change {Canister.count}.by 0
        end
      end
    end
  end
end
