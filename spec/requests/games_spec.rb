require 'rails_helper'

RSpec.describe 'Games', type: :request do
  let(:user) { create(:user) }

  describe '#create' do
    context 'when user is anonymous' do
      before { post games_path }

      it 'redirects to login form' do
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'shows an alert message' do
        expect(flash[:alert]).to be
      end
    end

    context 'when user is signed in' do
      before { sign_in user }

      context 'and params are invalid' do
        let(:invalid_params) { { game: { title: '' } } }

        it 'renders a new game page' do
          post games_path, params: invalid_params
          expect(response).to have_http_status(:ok)
        end

        it 'does not change the number of games' do
          expect { post games_path, params: invalid_params }.not_to change(Game, :count)
        end
      end

      context 'and params are valid' do
        let(:game) { build(:game) }
        let(:valid_params) { { game: game.attributes } }
        before { post games_path, params: valid_params }

        it 'redirects to the game page' do
          expect(response).to redirect_to(game_path(Game.last))
        end

        it 'shows a notice message' do
          expect(flash[:notice]).to be
        end

        it 'changes the number of games' do
          expect { post games_path, params: valid_params }.to change(Game, :count).by(1)
        end
      end
    end
  end

  describe '#new' do
    context 'when user is anonymous' do
      before { get new_game_path }

      it 'redirects to sign in' do
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'shows an alert message' do
        expect(flash[:alert]).to be
      end
    end

    context 'when user is signed in' do
      before do
        sign_in user
        get new_game_path
      end

      it 'renders a new game page' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#update' do
    before { sign_in user }
    let(:game) { create(:game, user:) }

    context 'with invalid params' do
      before { put "/games/#{game.id}", params: { game: { title: '' } } }

      it 'renders an edit game page' do
        expect(response).to have_http_status(:ok)
      end

      it 'keeps the attribute the same' do
        expect(game.reload.title).to eq 'Game'
      end
    end

    context 'with valid params' do
      before { put "/games/#{game.id}", params: { game: { title: 'Poker', pincode: '000' } } }

      it 'redirects to the game page' do
        expect(response).to redirect_to(game_path(game))
      end

      it 'shows a notice message' do
        expect(flash[:notice]).to be
      end

      it 'changes the attribute' do
        expect(game.reload.title).to eq 'Poker'
      end

      it 'sets the pincode' do
        expect(game.reload.pincode).to eq '000'
      end

      it 'does not render the pincode form for a game host' do
        expect(response.body).not_to include(I18n.t('views.games.password_form.pincode_access'))
      end
    end
  end

  describe '#destroy' do
    before { sign_in user }
    let(:game) { create(:game, user:) }
    before { delete "/games/#{game.id}" }

    it 'deletes the game' do
      expect(Game.exists?(game.id)).to be false
    end

    it 'redirects to root path' do
      expect(response).to redirect_to(root_path)
    end

    it 'shows a notice message' do
      expect(flash[:notice]).to be
    end
  end
end
