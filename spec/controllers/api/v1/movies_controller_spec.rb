require "rails_helper"

RSpec.describe Api::V1::MoviesController, type: :controller do
  let(:user) { instance_double(User) }

  describe "#index" do
    context "when user authorised" do
      before do
        allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      end

      it "returns success" do
        get :index, format: :json

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "#show" do
    context "when user authorised" do
      before do
        allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      end

      it "returns success" do
        allow(Movie).to receive(:find).and_return(instance_double(Movie, decorate: true))

        get :show, params: { format: :json, id: 111 }

        expect(response).to have_http_status(:success)
      end
    end
  end
end
