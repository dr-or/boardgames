require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'attached avatar' do
    it 'has a small variant' do
      expect(user.avatar.variant(:small)).to be_truthy
    end

    it 'has a thumb variant' do
      expect(user.avatar.variant(:thumb)).to be_truthy
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:games).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:subscriptions).dependent(:destroy) }
    it { is_expected.to have_many(:photos).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(40) }

    it { is_expected.to have_one_attached(:avatar) }
    it { is_expected.to validate_content_type_of(:avatar).allowing('image/png', 'image/jpeg', 'image/jpg') }
    it { is_expected.to validate_content_type_of(:avatar).rejecting('image/gif') }
    it { is_expected.to validate_size_of(:avatar).less_than(1.megabyte) }
  end

  describe '#link_subscriptions' do
    it 'updates subscription user_id' do
      subscription = Subscription.create(user_id: nil, user_email: 'example@mail.com')
      custom_user = User.create(name: 'John', email: 'example@mail.com')
      expect(subscription.user_id).to eq(custom_user.id)
    end
  end
end
