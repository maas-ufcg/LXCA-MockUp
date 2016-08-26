require 'rails_helper'

RSpec.describe Chassi, type: :model do
  describe "Validity of Chassi Model" do


    context "Factory :chassi" do
      before :each do
        @valid_chassi = build :chassi
      end

      it ":chassi factory should build a valid object" do
        expect(@valid_chassi).to be_valid(Chassi)
      end

      it "saving a new chassi should change the number of elements on DB" do
        expect {@valid_chassi.save}.to change {Chassi.count}.by 1
      end

      it "chassi._id show be equal to chassi.properties[:uuid]" do
        expect(@valid_chassi._id).to eq(@valid_chassi.properties[:uuid])
      end

      ChassisHelper::required_fields.each do |field|
        it "expect field #{field} can't be nil or empty string" do
          expect(@valid_chassi.properties[field]).to_not eq(nil)
          expect(@valid_chassi.properties[field]).to_not eq("")
        end
      end
    end

    ChassisHelper::required_fields.each do |field|
      context "Factory :no_#{field}_chassi" do
        before :each do
          @chassi = build :"no_#{field}_chassi"
        end

        it ":no_#{field}_chassi factory should not build an invalid object" do
          expect(@chassi).to_not be_valid(Chassi)
        end

        it "saving fan without #{field} should not change the number of elements in DB" do
          expect {@chassi.save}.to change {Chassi.count}.by 0
        end
      end

      context "Factory :nil_#{field}_chassi" do
        before :each do
          @chassi = build :"no_#{field}_chassi"
        end

        it ":no_#{field}_chassi factory should not build an invalid object" do
          expect(@chassi).to_not be_valid(Chassi)
        end

        it "saving fan without #{field} should not change the number of elements in DB" do
          expect {@chassi.save}.to change {Chassi.count}.by 0
        end
      end

      context "Factory :empty_string_#{field}_chassi" do
        before :each do
          @chassi = build :"empty_string_#{field}_chassi"
        end

        it ":empty_string_#{field}_chassi should not build an invalid object" do
          expect(@chassi).to_not be_valid(Chassi)
        end

        it "saving chassi without #{field} should not change the number of elements in DB" do
          expect {@chassi.save}.to change {Chassi.count}.by 0
        end
      end
    end
  end
end
