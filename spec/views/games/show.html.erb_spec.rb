require 'rails_helper'

RSpec.describe 'games/show', type: :view do
  let(:game) { create(:game) }
  before do
    assign(:game, game)
    without_partial_double_verification do
      allow(view).to receive(:current_user_can_edit?).and_return(false)
    end
    render
  end

  describe 'photo section' do
    context 'with anonymous user' do
      context 'and no photos' do
        it 'does not render the section title' do
          expect(rendered).not_to include(I18n.t('views.games.show.photos'))
        end

        it 'does not render the form for attaching photos' do
          expect(rendered).not_to include(I18n.t('activerecord.attributes.photo.photo'))
        end
      end

      context 'and a photo' do
        let(:photo) { create(:photo, game:) }
        before do
          assign(:photo, photo)
          render
        end

        it 'renders the section title' do
          expect(rendered).to include(I18n.t('views.games.show.photos'))
        end

        it 'does not render the form for attaching photos' do
          expect(rendered).not_to include(I18n.t('activerecord.attributes.photo.photo'))
        end
      end
    end

    context 'with signed-in user' do
      let(:user) { build_stubbed(:user) }
      before do
        allow(view).to receive(:user_signed_in?).and_return(true)
        allow(view).to receive(:current_user).and_return(user)
        render
      end

      it 'renders the section title' do
        expect(rendered).to include(I18n.t('views.games.show.photos'))
      end

      it 'renders the form for attaching photos' do
        expect(rendered).to include(I18n.t('activerecord.attributes.photo.photo'))
      end
    end
  end
end
