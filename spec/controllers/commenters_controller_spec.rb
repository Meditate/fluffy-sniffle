require "rails_helper"

RSpec.describe CommentersController, type: :controller do
  describe "#index" do
    let(:facade) do
      instance_double(
        CommentersController::IndexFacade,
        commenters: []
      )
    end

    it "returns success" do
      expect(CommentersController::IndexFacade)
        .to receive(:new)
        .and_return(facade)

      get :index

      expect(facade).to have_received(:commenters)
      expect(response).to have_http_status(:success)
    end
  end
end
