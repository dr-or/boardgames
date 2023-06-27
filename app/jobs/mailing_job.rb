class MailingJob < ApplicationJob
  queue_as :default

  def perform(object)
    case object
    when Subscription
      GameMailer.subscription(object).deliver_later
    else
      notify_subscribers(object)
    end
  end

  private

  def notify_subscribers(object)
    game = object.game
    all_emails = (
      game.subscriptions.map(&:user_email) + [game.user.email] - [object.user&.email]
    ).uniq

    if object.instance_of?(Comment)
      all_emails.each { |email| GameMailer.comment(object, email).deliver_later }
    else
      all_emails.each { |email| GameMailer.photo(object, email).deliver_later }
    end
  end
end
