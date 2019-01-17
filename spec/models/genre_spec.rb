require "rails_helper"

RSpec.describe Genre, type: :model do
  describe "#movies_count" do
    let(:genre) { build(Genre) }

    it "returns movie count for specific genre" do
      allow(genre).to receive(:movies).and_return([1, 2])
      expect(genre.movies_count).to be_eql(2)
    end
  end

  describe "#self.movies_count" do
    let(:klass) { class_double(Genre) }
    let(:genre) { double(id: 1, count: 1) }

    it "return dictionary with genre - movies count" do
      expect(Genre).to receive(:left_outer_joins).and_return(klass)
      expect(klass).to receive(:select).and_return(klass)
      expect(klass).to receive(:group).and_return([genre])
      expect(described_class.movies_count).to match_array(
        [{
          id: 1,
          count: 1
        }]
      )
    end
  end
end
