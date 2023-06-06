require "rails_helper"

RSpec.describe GamePolicy do
  let(:host) { create(:user) }
  let(:user) { create(:user) }

  let(:game) { create(:game, user: host) }
  let(:game_with_pincode) { create(:game, user: host, pincode: "1") }

  let(:game_context) { GameContext.new(game: game) }
  let(:game_context_with_correct_pincode) { GameContext.new(game: game_with_pincode, pincode: "1") }
  let(:game_context_with_incorrect_pincode) { GameContext.new(game: game_with_pincode, pincode: "2") }

  subject { GamePolicy }

  describe "#destroy?, #update?, #edit?, #new?, #create?" do
    context "when user is a game host" do
      permissions :destroy?, :update?, :edit?, :new?, :create? do
        it "grants access" do
          expect(subject).to permit(host, game)
        end
      end
    end

    context "when user is only registered" do
      permissions :destroy?, :update?, :edit? do
        it "denies access" do
          expect(subject).not_to permit(user, game)
        end
      end

      permissions :new?, :create? do
        it "grants access" do
          expect(subject).to permit(user, Game)
        end
      end
    end

    context "when user is not registered" do
      permissions :destroy?, :update?, :edit?, :new?, :create? do
        it "denies access" do
          expect(subject).not_to permit(nil, game)
        end
      end
    end
  end

  describe "#show?" do
    context "when a game page does not have a pincode" do
      context "and user is registered" do
        permissions :show? do
          it { is_expected.to permit(user, game_context) }
        end
      end

      context "and user is not registered" do
        permissions :show? do
          it { is_expected.to permit(nil, game_context) }
        end
      end
    end

    context "when a game page has a pincode" do
      context "and registered user has entered the correct pincode" do
        permissions :show? do
          it { is_expected.to permit(user, game_context_with_correct_pincode) }
        end
      end

      context "and anonymous user has entered the correct pincode" do
        permissions :show? do
          it { is_expected.to permit(nil, game_context_with_correct_pincode) }
        end
      end

      context "and registered user has entered an incorrect pincode" do
        permissions :show? do
          it { is_expected.not_to permit(user, game_context_with_incorrect_pincode) }
        end
      end

      context "and anonymous user has entered an incorrect pincode" do
        permissions :show? do
          it { is_expected.not_to permit(nil, game_context_with_incorrect_pincode) }
        end
      end
    end
  end
end
