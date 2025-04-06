class ReminderEmailJob < ApplicationJob
  queue_as :default

  def perform
    settings = AppSettings.current

    return if settings.remind_after_quantity.blank? || settings.remind_after_unit.blank?

    # Koliko dugo mora korisnik biti neaktivan da bi mu se poslao reminder
    inactivity_duration = settings.remind_after_quantity.send(settings.remind_after_unit)
    inactive_since = Time.current - inactivity_duration

    # Pronađi korisnike koji nikad nisu bili prijavljeni ili su bili neaktivni dulje od limita
    users_to_remind = User.where("last_sign_in_at IS NULL OR last_sign_in_at < ?", inactive_since)

    users_to_remind.find_each do |user|
      UserMailer.reminder_email(user).deliver_later
    end
  end
end
