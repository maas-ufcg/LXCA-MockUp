require 'rails_helper'
require 'securerandom'

RSpec.describe FansController, type: :controller do


  describe "GET #index" do
    context "for six existing valid fans" do
      context "Without excludeAttributes or includeAttributes parameters" do
        before :each do
          @fans = (0..5).map {|n| create :valid_fan}
          get :index
        end

        it "must assign an Array to @fans" do
          expect(assigns :fans).to be_a(Array)
        end

        it "must store all six fans assigned to @fans" do
          expect(assigns(:fans).count).to eq(6)
        end

        it "all fans in @fans must be valid" do
          assigns(:fans).each do |fan|
            expect(fan).to be_valid(Fan)
          end
        end

        it "must render have HTTP Status 200 (OK)" do
          expect(response).to have_http_status(:success)
        end
      end

      context "With includeAttributes parameters" do
        before :each do
          @includeAttributes = %i(
            description
            hardwareRevision
            dataHandle
          )
          @fans = (0..5).map {|n| create :valid_fan}
          get :index, {includeAttributes: @includeAttributes.join(",")}
        end

        it "must assign an Array to @fans" do
          expect(assigns :fans).to be_a(Array)
        end

        it "must store all six fans assigned to @fans" do
          expect(assigns(:fans).count).to eq(6)
        end

        it "All fans have the attributes included" do
          assigns(:fans).each do |fan| 
            @includeAttributes.each do |attribute|
              expect(fan.properties.has_key? attribute).to eq(true)
            end
          end
        end

        it "All fans doesn't have all other attributes" do
          assigns(:fans).each do |fan| 
            absent = FansHelper::required_fields - @includeAttributes
            absent.each do |attribute|
              expect(fan.properties.has_key? attribute).to eq(false)
            end
          end
        end

        it "must render have HTTP Status 200 (OK)" do
          expect(response).to have_http_status(:success)
        end
      end

      context "With excludeAttributes parameters" do
        before :each do
          @excludeAttributes = %i(
            description
            hardwareRevision
            dataHandle
          )
          @fans = (0..5).map {|n| create :valid_fan}
          get :index, {excludeAttributes: @excludeAttributes.join(",")}
        end

        it "must assign an Array to @fans" do
          expect(assigns :fans).to be_a(Array)
        end

        it "must store all six fans assigned to @fans" do
          expect(assigns(:fans).count).to eq(6)
        end

        it "All fans doesn't have the attributes excluded" do
          assigns(:fans).each do |fan| 
            @excludeAttributes.each do |attribute|
              expect(fan.properties.has_key? attribute).to eq(false)
            end
          end
        end

        it "must render have HTTP Status 200 (OK)" do
          expect(response).to have_http_status(:success)
        end
      end
    end
  end

  describe "GET #show" do
    context "Fetching existing fans" do
      context "Without excludeAttributes or includeAttributes parameters" do
        before :each do
          @fans = (0..5).map {|n| create :valid_fan}
        end

        it "All fans can be fetched individually" do
          @fans.each do |fan| 
            get :show, {id: fan._id}
            expect(response).to have_http_status(:success)
          end
        end

        it "All fans are valid" do
          @fans.each do |fan| 
            get :show, {id: fan._id}
            expect(assigns :fan).to be_valid(Fan)
          end
        end
      end

      context "With excludeAttributes parameters" do
        before :each do
          @excludeAttributes = %i(
            description
            hardwareRevision
            dataHandle
          )
          @fans = (0..5).map {|n| create :valid_fan}
        end

        it "All fans can be fetched individually" do
          @fans.each do |fan| 
            get :show, {
              id: fan._id, 
              excludeAttributes: @excludeAttributes.join(",")
            }
            expect(response).to have_http_status(:success)
          end
        end

        it "All fans doesn't have the attributes excluded" do
          @fans.each do |fan| 
            get :show, {
              id: fan._id, 
              excludeAttributes: @excludeAttributes.join(",")
            }
            @excludeAttributes.each do |attribute|
              fan_properties = assigns(:fan).properties
              expect(fan_properties.has_key? attribute).to eq(false)
            end
          end
        end
      end

      context "With includeAttributes parameters" do
        before :each do
          @includeAttributes = %i(
            description
            hardwareRevision
            dataHandle
          )
          @fans = (0..5).map {|n| create :valid_fan}
        end

        it "All fans can be fetched individually" do
          @fans.each do |fan| 
            get :show, {
              id: fan._id, 
              includeAttributes: @includeAttributes.join(",")
            }
            expect(response).to have_http_status(:success)
          end
        end

        it "All fans have the attributes included" do
          @fans.each do |fan| 
            get :show, {
              id: fan._id, 
              includeAttributes: @includeAttributes.join(",")
            }
            @includeAttributes.each do |attribute|
              fan_properties = assigns(:fan).properties
              expect(fan_properties.has_key? attribute).to eq(true)
            end
          end
        end

        it "All fans doesn't have other attributes" do
          @fans.each do |fan| 
            get :show, {
              id: fan._id, 
              includeAttributes: @includeAttributes.join(",")
            }
            absent = FansHelper::required_fields - @includeAttributes
            absent.each do |attribute|
              fan_properties = assigns(:fan).properties
              expect(fan_properties.has_key? attribute).to eq(false)
            end
          end
        end
      end
    end

    context "Fetching unexisting fans" do
      before :each do
        @random_id = SecureRandom.hex.upcase
        get :show, {id: @random_id}
      end

      it "Returns HTTP Status Code 404 (Not Found)" do
        expect(response).to have_http_status(:not_found)
      end

      it "Expects to assign nil to @fan in action" do
        expect(assigns :fan).to be_nil
      end
    end
  end

end
