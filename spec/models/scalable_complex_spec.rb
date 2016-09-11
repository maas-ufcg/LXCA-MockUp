RSpec.describe ScalableComplex, type: :model do

	pending "add some examples to (or delete) #{__FILE__}"

	describe "Model validations:" do
		context "Factory :scalableComplex" do
			before :each do
				@scalableComplex = build :scalableComplex
			end

			it "is consistent." do
				expect(@scalableComplex).to be_valid(ScalableComplex)
			end

			it "can be save." do
				expect{
					@scalableComplex.save
				}.to change{ScalableComplex.count}.by 1
			end
		end

		context "Factory :inv_scalableComplex_different_id_and_uuid" do
        before :each do
              @scalableComplex = build :inv_scalableComplex_different_id_and_uuid
        end
        it "Factory :inv_scalableComplex_different_id_and_uuid should not build a valid object." do
            expect(@scalableComplex).to_not be_valid(ScalableComplex)
        end

        it "Should not save a object with _id and properties.uuid different" do
            expect{@scalableComplex.save}.to change{ScalableComplex.count}.by 0
        end
    end

    ScalableComplexHelper::required_fields.each do |key|
      context "Factory :no_#{key}_scalableComplex" do
        before :each do
          @scalableComplex = build :"no_#{key}_scalableComplex"
        end

        it ":no_#{key}_scalableComplex factory should build an invalid object." do
          expect(@scalableComplex).to_not be_valid(ScalableComplex)
        end

        it "should not save scalableComplex missing #{key}, the number of elements in BD should not change." do
          expect{@scalableComplex.save}.to change{ScalableComplex.count}.by 0
        end

      end

    end

    ScalableComplexHelper::defined_fields.each do |key|
     context "Factory invalid values for '#{key}'" do
       before :each do
         @scalableComplex = build :"invalid_#{key}_scalableComplex"
       end

       it ":invalid_#{key}_scalableComplex factory should build an invalid object" do
         expect(@scalableComplex).to_not be_valid(ScalableComplex)
       end
       it "should not save scalable Complex with invalid #{key}, the number of elements in BD should not change." do
         expect{@scalableComplex.save}.to change{ScalableComplex.count}.by 0
       end
      end
    end
	end
end
