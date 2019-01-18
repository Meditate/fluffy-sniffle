require "rails_helper"

RSpec.describe CommentersController::IndexFacade, type: :helper do
  let(:facade) { described_class.new }
  describe "#commenters" do
    let!(:user_1) { create(:user) }
    let!(:comment_1_1) { create(:comment, user: user_1) }
    let!(:comment_1_2) { create(:comment, user: user_1) }
    let!(:user_2) { create(:user) }
    let!(:comment_2_1) { create(:comment, user: user_2) }
    let!(:comment_2_2) { create(:comment, user: user_2, created_at: Date.parse("2000-01-01")) }
    let!(:comments) { create_list(:comment, 7, user: user_1) }

    it "returns AR collection" do
      expect(facade.commenters).to be_an(ActiveRecord::Relation)
    end

    it "doesn't count old comments" do
      expect(facade.commenters.find(user_2.id).comments_count).to eql(1)
    end

    it "doesn't return more then 10 records" do
      allow(User).to receive_message_chain(:joins, :select, :where, :group, :order)
        .and_return(Comment.all)
      expect(facade.commenters.count).to be_eql(10)
    end
  end
end
