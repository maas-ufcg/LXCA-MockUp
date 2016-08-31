require 'rails_helper'

RSpec.describe FanMux, type: :model do

  describe "Validity of FanMux Model" do
    context "Factory :fan_mux" do
      before :each do
        @valid_fan_mux = build :fan_mux
      end

      it ":fan_mux factory should build a valid object" do
        expect(@valid_fan_mux).to be_valid(FanMux)
      end

      it "saving a new fan_mux should change the number of elements in DB" do
        expect {@valid_fan_mux.save}.to change {FanMux.count}.by 1
      end

      it "fan_mux._id show be equal to fan_mux.properties[:uuid]" do
        expect(@valid_fan_mux._id).to eq(@valid_fan_mux.properties[:uuid])
      end

      FanMuxesHelper::required_fields.each do |field|
        it "expect field #{field} not not be nil or empty string" do
          expect(@valid_fan_mux.properties[field]).to_not eq(nil)
          expect(@valid_fan_mux.properties[field]).to_not eq("")
        end
      end
    end

    FanMuxesHelper::required_fields.each do |field|
      context "Factory :no_#{field}_fan_mux" do
        before :each do
          @fan_mux = build :"no_#{field}_fan_mux"
        end

        it ":no_#{field}_fan_mux factory should build an invalid object" do
          expect(@fan_mux).to_not be_valid(FanMux)
        end

        it "saving fan_mux without #{field} should not change the number of elements in DB" do
          expect {@fan_mux.save}.to change {FanMux.count}.by 0
        end
      end

      context "Factory :nil_#{field}_fan_mux" do
        before :each do
          @fan_mux = build :"nil_#{field}_fan_mux"
        end

        it ":nil_#{field}_fan_mux factory should build an invalid object" do
          expect(@fan_mux).to_not be_valid(FanMux)
        end

        it "saving fan_mux without #{field} should not change the number of elements in DB" do
          expect {@fan_mux.save}.to change {FanMux.count}.by 0
        end
      end

      context "Factory :empty_string_#{field}_fan_mux" do
        before :each do
          @fan_mux = build :"empty_string_#{field}_fan_mux"
        end

        it ":empty_string_#{field}_fan_mux factory should build an invalid object" do
          expect(@fan_mux).to_not be_valid(FanMux)
        end

        it "saving fan_mux without #{field} should not change the number of elements in DB" do
          expect {@fan_mux.save}.to change {FanMux.count}.by 0
        end
      end
    end
  end
end
