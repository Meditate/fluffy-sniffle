require "rails_helper"

RSpec.describe CommentsController::DestroyFacade, type: :helper do
  describe "#delete" do
    let!(:comment) { build(Comment) }
    let!(:user) { build(User) }

    let(:params) do
      ActionController::Parameters.new(
        comment: {
          id: comment.id
        }
      )
    end

    it "removes comment" do
      facade = described_class.new(params, user)
      expect(facade).to receive(:comment).and_return(comment)
      expect(comment).to receive(:destroy)
      facade.delete
    end
  end
end
