require 'rails_helper'

RSpec.describe Fan, type: :model do

  describe "Validity of Fan Model" do
    context "Factory :fan" do
      before :each do
        @valid_fan = build :fan
      end

      it ":fan factory should build a valid object" do
        expect(@valid_fan).to be_valid(Fan)
      end

      it "saving a new fan should change the number of elements in DB" do
        expect {@valid_fan.save}.to change {Fan.count}.by 1
      end

      it "fan._id show be equal to fan.properties[:uuid]" do
        expect(@valid_fan._id).to eq(@valid_fan.properties[:uuid])
      end

      FansHelper::required_fields.each do |field|
        it "expect field #{field} not not be nil or empty string" do
          expect(@valid_fan.properties[field]).to_not eq(nil)
          expect(@valid_fan.properties[field]).to_not eq("")
        end
      end
    end

    FansHelper::required_fields.each do |field|
      context "Factory :no_#{field}_fan" do
        before :each do
          @fan = build :"no_#{field}_fan"
        end

        it ":no_#{field}_fan factory should build an invalid object" do
          expect(@fan).to_not be_valid(Fan)
        end

        it "saving fan without #{field} should not change the number of elements in DB" do
          expect {@fan.save}.to change {Fan.count}.by 0
        end
      end

      context "Factory :nil_#{field}_fan" do
        before :each do
          @fan = build :"nil_#{field}_fan"
        end

        it ":nil_#{field}_fan factory should build an invalid object" do
          expect(@fan).to_not be_valid(Fan)
        end

        it "saving fan without #{field} should not change the number of elements in DB" do
          expect {@fan.save}.to change {Fan.count}.by 0
        end
      end

      context "Factory :empty_string_#{field}_fan" do
        before :each do
          @fan = build :"empty_string_#{field}_fan"
        end

        it ":empty_string_#{field}_fan factory should build an invalid object" do
          expect(@fan).to_not be_valid(Fan)
        end

        it "saving fan without #{field} should not change the number of elements in DB" do
          expect {@fan.save}.to change {Fan.count}.by 0
        end
      end
    end
  end
end
