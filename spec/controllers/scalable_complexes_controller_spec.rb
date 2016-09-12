require 'rails_helper'

RSpec.describe ScalableComplexController, type: :contoller do
  describe "GET #index" do
    context "for 6 existing valid scalable complexes" do
      before :each do
        @scalableComplexes = (0..5).map{|n| create :valid_scalableComplex}
        get :index
      end

      it "must assign an Array to @power_supplies" do
        expect(@scalableComplexes).to be_a(Array)
      end

      it "must store all six power_supplies assigned to @power_supplies" do
        expect(@scalableComplexes.count).to eq(6)
      end

      it "all power_supplies in @power_supplies must be valid" do
        @scalableComplexes.each do |scalableComplex|
          expect(scalableComplex).to be_valid(PowerSupply)
        end
      end

      it "must render have HTTP Status 200 (OK)" do
        expect(response).to have_http_status(:success)
      end
    end

    context "With includeAttributes parameters" do
      before :each do
        @includeAttributes = %i{
          nodeCount
        }
        @scalableComplexes = (0..5).map{|n| create :valid_scalableComplex}
        get :index, {includeAttributes: @includeAttributes.join(",")}
      end

      it "must assign an array to @scalableComplexes" do
        expect(@scalableComplexes).to be_a(Array)
      end

      it "must store all six scalable complexes assigned at @scalableComplexes" do
        expect(@scalableComplexes).to eq(6)
      end

      it "All scalable complexes have the attributes included" do
        assigns(:scalableComplexes).each do |scalable_complex|
          @includeAttributes.each do |attribute|
            expect(scalable_complex.properties.has_key? attribute).to eq(true)
          end
        end
      end

      it "All scalable complexes doesn't have all other attributes" do
        assigns(:scalableComplexes).each do |scalable_complex|
          absent = ScalableComplexHelper::required_fields - @includeAttributes
          absent.each do |attribute|
            expect(scalable_complex.properties.has_key? attribute).to eq(false)
          end
        end
      end

      it "must render have HTTP Status 200 (OK) response" do
        expect(response).to have_http_status(:success)
      end
    end

    context "With excludeAttributes parameters" do
      before :each do
        @excludeAttributes = %i{
          nodeCount
        }
        @scalableComplexes = (0..5).map{|n| create :valid_scalableComplex}
        get :index, {includeAttributes: @includeAttributes.join(",")}
      end

      it "must assigns an Array to @scalableComplexes" do
        expect(@scalableComplexes).to be_a(Array)
      end

      it "All scalableComplexes doesn't have the attributes excluded" do
        assigns(:scalableComplexes).each do |scalable_complex|
          @excludeAttributes.each do |attribute|
            expect(scalable_complex.properties.has_key? attribute).to eq(false)
          end
        end
      end

      it "must render have HTTP Status 200 (OK) response" do
        expect(response).to have_http_status(:success)
      end
    end

  end

  describe "GET #show" do
    context "Fetching existing scalableComplexes" do
      context "Without excludeAttributes or includeAttributes parameters" do
        before :each do
          @scalableComplexes = (0..5).map {|n| create :valid_scalableComplex}
        end

        it "All scalableComplexes can be fetched individually" do
          @scalableComplexes.each do |scalable_complex|
            get :show, {id: scalable_complex._id}
            expect(response).to have_http_status(:success)
          end
        end

        it "All scalableComplexes are valid" do
          @scalableComplexes.each do |scalable_complex|
            get :show, {id: scalable_complex._id}
            expect(power_supply).to be_valid(ScalableComplex)
          end
        end
      end

      context "With excludeAttributes parameters" do
        before :each do
          @excludeAttributes = %i(
          nodeCount
          )
          @scalableComplexes = (0..5).map {|n| create :valid_scalableComplex}
        end

        it "All scalableComplexes can be fetched individually" do
          @scalableComplexes.each do |scalable_complex|
            get :show, {
              id: scalable_complex._id,
              excludeAttributes: @excludeAttributes.join(",")
            }
            expect(response).to have_http_status(:success)
          end
        end

        it "All scalableComplexes doesn't have the attributes excluded" do
          @scalableComplexes.each do |scalable_complex|
            get :show, {
              id: scalable_complex._id,
              excludeAttributes: @excludeAttributes.join(",")
            }
            @excludeAttributes.each do |attribute|
              scalable_complex_properties = assigns(:scalable_complex).properties
              expect(scalable_complex_properties.has_key? attribute).to eq(false)
            end
          end
        end
      end
    end
  end
end
