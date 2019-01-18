require "rails_helper"

RSpec.describe Movie do
  describe "relations" do
    it { is_expected.to have_many(:comments) }
  end
end
