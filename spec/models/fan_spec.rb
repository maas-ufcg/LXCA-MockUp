require 'rails_helper'

RSpec.describe Fan, type: :model do

  required_fields = %i(
    cmmDisplayName cmmHealthState dataHandle firmware FRU
    fruSerialNumber hardwareRevision manufacturer manufacturerID
    name parent partNumber posID powerState uri uuid vpdID
  )

  describe "Validity of Factories" do
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

      required_fields.map do |field|
        it "expect field #{field} not not be nil or empty string" do
          expect(@valid_fan.properties[field]).to_not eq(nil)
          expect(@valid_fan.properties[field]).to_not eq("")
        end
      end
    end
  end
end
