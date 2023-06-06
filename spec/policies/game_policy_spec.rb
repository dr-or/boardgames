require "rails_helper"

RSpec.describe GamePolicy do
  let(:host) { create(:user) }
  let(:guest) { create(:user) }
  let(:game) { create(:game, user: host) }
  subject { GamePolicy }

  context "when user is a game host" do
    permissions :destroy?, :update?, :edit?, :show? do
      it "grants access" do
        expect(subject).to permit(host, game)
      end
    end
  end

  context "when user is a guest" do
    permissions :destroy?, :update?, :edit? do
      it "denies access" do
        expect(subject).not_to permit(guest, game)
      end
    end

    permissions :show? do
      it "grants access" do
        expect(subject).to permit(guest, game)
      end
    end
  end
end
