require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:game) }
    it { is_expected.to belong_to(:user).optional }
  end

  describe 'validations if user is present' do
    subject { build(:subscription, :with_present_user) }
    it { is_expected.to validate_uniqueness_of(:user).scoped_to(:game_id) }

    let(:game) { create(:game) }
    let(:internal_sub) { create(:subscription, :with_present_user, game: game, user: game.user) }
    it 'raises the error' do
      expect { internal_sub }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'validations unless user is present' do
    subject { build(:subscription, :without_present_user) }
    it { is_expected.to validate_presence_of(:user_name) }
    it { is_expected.to validate_presence_of(:user_email) }
    it { is_expected.to validate_uniqueness_of(:user_email).scoped_to(:game_id) }

    let(:user) { create(:user) }
    let(:external_sub) { create(:subscription, :without_present_user, user_email: user.email) }
    it 'raises the error' do
      expect { external_sub }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
