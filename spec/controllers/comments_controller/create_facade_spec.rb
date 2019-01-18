require "rails_helper"

RSpec.describe CommentsController::CreateFacade, type: :helper do
  describe "#save" do
    let!(:user) { create(User) }
    let!(:comment) { build(Comment) }
    let!(:movie) { create(Movie) }
    let(:params) do
      ActionController::Parameters.new(
        comment: {
          commentable_id: movie.id,
          commentable_type: movie.class.name,
          body: "test"
        }
      )
    end

    context "when user can comment" do
      it "saves comment" do
        facade = described_class.new(params, user)
        expect { facade.save }.to change(Comment, :count).by(1)
      end
    end

    context "when user can't comment" do
      it "returns false" do
        facade = described_class.new(params, user)
        allow(facade).to receive(:can_comment?).and_return(false)
        expect(facade.save).to be_falsey
      end
    end
  end
end
