require 'rails_helper'

RSpec.describe GameMailer, type: :mailer do
  describe '#subscription' do
    let(:game) { create(:game) }
    let(:subscription) { create(:subscription, :with_present_user, game:) }
    let(:mail) { GameMailer.subscription(subscription) }

    it 'renders the subject' do
      expect(mail.subject).to include(I18n.t('game_mailer.subscription.subject', title: game.title))
    end

    it 'renders the mailto' do
      expect(mail.to).to eq([game.user.email])
    end

    it 'renders the mailfrom' do
      expect(mail.from).to eq([Rails.application.credentials.dig(:mail, :username)])
    end
  end
end
