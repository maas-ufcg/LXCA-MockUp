RSpec.describe Switch, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  describe "Model validations:" do
    context "Factory :switch" do
        before :each do
          @switch = build :switch

        end

        it "is consistent." do
          expect(@switch).to be_valid(Switch)
        end

        it "can be save." do
          expect{
            @switch.save
          }.to change {Switch.count}.by 1
        end

    end


    context "Factory :inv_switch_different_id_and_uuid" do
        before :each do
              @switch = build :inv_switch_different_id_and_uuid
        end
        it "Factory :inv_switch_different_id_and_uuid should not build a valid object." do
            expect(@switch).to_not be_valid(Switch)
        end

        it "Should not save a object with _id and properties.uuid different" do
            expect{@switch.save}.to change{Switch.count}.by 0
        end
    end

    SwitchesHelper::required_fields.each do |key|
      context "Factory :no_#{key}_switch" do
        before :each do
          @switch = build :"no_#{key}_switch"
        end

        it ":no_#{key}_switch factory should build an invalid object." do
          expect(@switch).to_not be_valid(Switch)
        end

        it "should not save switch missing #{key}, the number of elements in BD should not change." do
          expect{@switch.save}.to change{Switch.count}.by 0
        end

      end

    end

    SwitchesHelper::defined_fields.each do |key|
     context "Factory invalid values for '#{key}'" do
       before :each do
         @switch = build :"invalid_#{key}_switch" 
       end
     end

     it ":invalid_#{key}_switch factory should build an invalid object" do
       expect(@switch).to_not be_valid(Switch)
     end

    end
  end

end
