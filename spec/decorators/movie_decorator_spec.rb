require "rails_helper"

RSpec.describe MovieDecorator, type: :helper do
  let(:decorator) { MovieDecorator.new(movie) }
  let(:movie) { instance_double(Movie) }

  describe "#cover" do
    before do
      allow(movie).to receive(:poster).and_return("/test")
    end

    context "with fetched poster" do
      it "returns cover url" do
        expect(decorator.cover).to eql(Rails.application.secrets.movies_poster_api + movie.poster)
      end
    end

    context "with empty poster" do
      before do
        allow(movie).to receive(:poster)
      end

      it "returns sample cover url" do
        expect(decorator.cover).to include("lorempixel")
      end
    end
  end
end
