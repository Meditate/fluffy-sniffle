require "rails_helper"

describe User do
  describe "number validation" do
    it { is_expected.to allow_value("+48 999 888 777").for(:phone_number) }
    it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
    it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
    it { is_expected.not_to allow_value("+48 aaa bbb ccc").for(:phone_number) }
    it { is_expected.not_to allow_value("aaa +48 aaa bbb ccc").for(:phone_number) }
    it { is_expected.not_to allow_value("+48 999 888 777\naseasd").for(:phone_number) }
  end
  describe "relations" do
    it { is_expected.to have_many(:comments) }
  end
end
