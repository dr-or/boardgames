require 'rails_helper'

RSpec.describe 'layouts/_navbar', type: :view do
  context 'when user is anonymous' do
    it 'does not render the new game button' do
      render
      expect(rendered).not_to include(I18n.t('views.games.index.new_game'))
    end
  end

  context 'when user is signed in' do
    let(:user) { build_stubbed(:user) }
    before do
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'renders the new game button' do
      expect(rendered).to include(I18n.t('views.games.index.new_game'))
    end
  end
end
