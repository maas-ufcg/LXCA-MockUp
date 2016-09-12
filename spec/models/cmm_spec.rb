require 'rails_helper'

RSpec.describe Cmm, type: :model do
  describe "Validity of Cmm Model" do


    context "Factory :cmm" do
      before :each do
        @valid_cmm = build :cmm
      end

      it ":cmm factory should build a valid object" do
        expect(@valid_cmm).to be_valid(Cmm)
      end

       it "saving a new cmm should change the number of elements on DB" do
         expect {@valid_cmm.save}.to change {Cmm.count}.by 1
       end

       it "cmm._id show be equal to cmm.properties[:uuid]" do
         expect(@valid_cmm._id).to eq(@valid_cmm.properties[:uuid])
       end

       CmmsHelper::required_fields.each do |field|
         it "expect field #{field} can't be nil or empty string" do
           expect(@valid_cmm.properties[field]).to_not eq(nil)
           expect(@valid_cmm.properties[field]).to_not eq("")
         end
      end
    end

     CmmsHelper::required_fields.each do |field|
       context "Factory :no_#{field}_cmm" do
         before :each do
           @cmm = build :"no_#{field}_cmm"
         end

         it ":no_#{field}_cmm factory should build an invalid object" do
           expect(@cmm).to_not be_valid(Cmm)
         end

         it "saving cmm without #{field} should not change the number of elements in DB" do
           expect {@cmm.save}.to change {Cmm.count}.by 0
         end
       end
     end
  end
end
