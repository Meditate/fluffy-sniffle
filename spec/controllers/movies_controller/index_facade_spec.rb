require "rails_helper"

RSpec.describe MoviesController::IndexFacade, type: :helper do
  describe "#movies" do
    context "with correct api response" do
      before do
        stub_request(:get, /#{URI.parse(Rails.application.secrets.movies_api).host}/)
          .to_return(
            body: {
              "data": {
                "id": "6",
                "type": "movie",
                "attributes": {
                  "title": "Godfather",
                  "plot": "plot",
                  "rating": 9.2,
                  "poster": "/godfather.jpg"
                }
              }
            }.to_json
          )
      end

      it "returns movie mapping" do
        create(:movie)
        create(:movie)

        facade = described_class.new
        expect(facade.movies).to match_array(Movie.all.decorate)
      end
    end

    context "with unexpected api response" do
      before do
        stub_request(:get, /#{URI.parse(Rails.application.secrets.movies_api).host}/)
          .to_return(body: { error: "No movie" }.to_json)
      end

      it "returns movie mapping" do
        create(:movie)
        create(:movie)

        facade = described_class.new
        expect(facade.movies).to match_array(Movie.all.decorate)
      end
    end
  end
end
