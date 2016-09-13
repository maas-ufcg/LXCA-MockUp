require 'rails_helper'
require 'json'

RSpec.describe "ScalableComplex", type: :request do
  describe "GET /scalable_complex" do

    context "Without excludeAttributes or includeAttributes parameters" do

      before :each do
        @scalable_complexes = (0...6).map do |scalable_complex|
          create :scalable_complex
        end

          get scalable_complexes_path

      end

      it "HTTP response code is 200 (OK)" do
        expect(response).to have_http_status(:ok)
      end

      it "Response content-type must be json" do
        expect(response.content_type).to eq("application/json")
      end

      it "The body should contain an array of objects" do
        expect(JSON.parse(response.body)).to be_a(Array)
      end

      it "The body array should contain five items" do
        expect(JSON.parse(response.body).size).to eq(6)
      end

      it "All items in the array should be a json object" do
        JSON.parse(response.body).each do |object|
          expect(object).to be_a(Hash)
        end
      end

      it "All items in the array should be of type Scalable Complex" do
        JSON.parse(response.body).each do |object|
          expect(object["type"]).to eq("ScalableComplex")
        end
      end

    end

    context "With includeAttributes parameters" do
      before :each do
        @scalable_complexes = (0...5).map do |scalable_complex|
          create :scalable_complex
        end
        @includeAttributes = %i(
        nodeCount
        )

        get scalable_complexes_path, {includeAttributes: @includeAttributes.join(",")}
      end

      it "HTTP response code is 200 (OK)" do
        expect(response).to have_http_status(:ok)
      end

      it "Response content-type must be json" do
        expect(response.content_type).to eq("application/json")
      end

      it "The body should contain an array of objects" do
        expect(JSON.parse(response.body)).to be_a(Array)
      end

      it "The body array should contain five items" do
        expect(JSON.parse(response.body).size).to eq(5)
      end

      it "All items in the array should be a json object" do
        JSON.parse(response.body).each do |object|
          expect(object).to be_a(Hash)
        end
      end

      it "All items in response should've all the specified attributes" do
        JSON.parse(response.body).each do |object|
          @includeAttributes.each do |attribute|
            expect(object.has_key? attribute.to_s).to eq(true)
          end
        end
      end

      it "All items in response shouldn't have any attribute not specified" do
        JSON.parse(response.body).each do |object|
          absent = ScalableComplexHelper::required_fields - @includeAttributes
          absent.each do |attribute|
            expect(object.has_key? attribute.to_s).to eq(false)
          end
        end
      end
    end

  end
end
