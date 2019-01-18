require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  describe "#create" do
    let(:movie) { build(Movie) }
    let(:facade) do
      instance_double(
        CommentsController::CreateFacade,
        save: true,
        commentable: movie
      )
    end

    it "returns success" do
      expect(CommentsController::CreateFacade)
        .to receive(:new)
        .and_return(facade)

      post :create, params: { body: "test" }

      expect(response).to have_http_status(:redirect)
      expect(facade).to have_received(:save)
      expect(facade).to have_received(:commentable)
    end
  end

  describe "#destroy" do
    let(:movie) { build(Movie) }
    let(:facade) do
      instance_double(
        CommentsController::DestroyFacade,
        delete: true,
        commentable: movie
      )
    end

    it "returns success" do
      expect(CommentsController::DestroyFacade)
        .to receive(:new)
        .and_return(facade)

      delete :destroy, params: { id: 1 }

      expect(response).to have_http_status(:redirect)
      expect(facade).to have_received(:delete)
      expect(facade).to have_received(:commentable)
    end
  end
end
