require 'rails_helper'

RSpec.describe Photo, type: :model do
  let(:photo) { create(:photo) }

  describe 'associations' do
    it { is_expected.to belong_to(:game) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'attached photo' do
    it 'has a big variant' do
      expect(photo.photo.variant(:big)).to be_truthy
    end

    it 'has a thumb variant' do
      expect(photo.photo.variant(:thumb)).to be_truthy
    end
  end

  describe 'scope' do
    it 'shows saved photo' do
      expect(photo.persisted?).to be true
    end

    let(:unsaved_photo) { build(:photo) }
    it 'does not show unsaved photo' do
      expect(unsaved_photo.persisted?).to be false
    end
  end
  
  describe 'validations' do
    it { is_expected.to have_one_attached(:photo) }
    it { is_expected.to validate_attached_of(:photo) }
    it { is_expected.to validate_content_type_of(:photo).allowing('image/png', 'image/jpeg', 'image/jpg') }
    it { is_expected.to validate_content_type_of(:photo).rejecting('image/gif') }
    it { is_expected.to validate_size_of(:photo).less_than(1.megabyte) }
  end
end
