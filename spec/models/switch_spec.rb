RSpec.describe Switch, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  describe "Model validations:" do
    context "The Switch" do
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


  end

end
