require 'rails_helper'

RSpec.describe 'Subscriptions', type: :request do
  let(:game) { create(:game) }

  describe '#create' do
    context 'when user is anonymous' do
      let(:subscription) { build(:subscription, :without_present_user, game:) }

      context 'with invalid params' do
        let(:invalid_params) { { subscription: { user_name: '' } } }

        it 'renders the game page' do
          post game_subscriptions_path(game), params: invalid_params
          expect(response).to have_http_status(:ok)
        end

        it 'does not change the number of subscriptions' do
          expect do
            post game_subscriptions_path(game), params: invalid_params
          end.not_to change(Subscription, :count)
        end
      end

      context 'with valid params' do
        let(:valid_params) { { subscription: subscription.attributes } }

        it 'redirects to the game page' do
          post game_subscriptions_path(game), params: valid_params
          expect(response).to redirect_to(game_path(game))
          expect(flash[:notice]).to be
        end

        it 'changes the number of subscriptions' do
          expect do
            post game_subscriptions_path(game), params: valid_params
          end.to change(Subscription, :count).by(1)
        end
      end
    end

    context 'when user is signed in' do
      let(:user) { create(:user) }
      before { sign_in user }
      let(:subscription) { build(:subscription, :with_present_user, game:, user:) }

      it 'redirects to the game page' do
        post game_subscriptions_path(game)
        expect(response).to redirect_to(game_path(game))
        expect(flash[:notice]).to be
      end

      it 'changes the number of subscriptions' do
        expect { post game_subscriptions_path(game) }.to change(Subscription, :count).by(1)
      end
    end
  end

  describe '#destroy' do
    let(:user) { create(:user) }
    let(:subscription) { create(:subscription, :with_present_user, game:, user:) }

    context 'when user is anonymous' do
      before { delete game_subscription_path(subscription.game, subscription) }

      it 'has an alert message' do
        expect(flash[:alert]).to be
      end

      it 'does not destroy the record' do
        expect(Subscription.exists?(subscription.id)).to be true
      end
    end

    context 'when user is signed in' do
      context 'and is not a subscription owner' do
        let(:guest) { create(:user) }
        before { sign_in guest }
        before { delete game_subscription_path(subscription.game, subscription) }

        it 'has an alert message' do
          expect(flash[:alert]).to be
        end

        it 'does not destroy the record' do
          expect(Subscription.exists?(subscription.id)).to be true
        end
      end

      context 'and is a subscription owner' do
        before { sign_in user }
        before { delete game_subscription_path(subscription.game, subscription) }

        it 'has a notice message' do
          expect(flash[:notice]).to be
        end

        it 'destroys the record' do
          expect(Subscription.exists?(subscription.id)).to be false
        end
      end

      context 'and is a game owner' do
        before { sign_in game.user }
        before { delete game_subscription_path(subscription.game, subscription) }

        it 'has a notice message' do
          expect(flash[:notice]).to be
        end

        it 'destroys the record' do
          expect(Subscription.exists?(subscription.id)).to be false
        end
      end
    end
  end
end
