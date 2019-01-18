require "rails_helper"

RSpec.describe MoviesController, type: :controller do
  describe "#index" do
    let(:facade) do
      instance_double(
        MoviesController::IndexFacade,
        movies: []
      )
    end

    it "returns success" do
      expect(MoviesController::IndexFacade)
        .to receive(:new)
        .and_return(facade)

      get :index, xhr: true

      expect(response).to have_http_status(:success)
      expect(facade).to have_received(:movies)
    end
  end
end
