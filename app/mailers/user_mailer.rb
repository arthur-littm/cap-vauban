class UserMailer < ApplicationMailer

  def new_booking(user, booking)
    @user = user  # Instance variable => available in view
    @booking = booking
    mail(to: @user.email, subject: 'Cap Vauban - #{t("mailer.new_booking_subject")}')
    # This will render a view in `app/views/user_mailer`!
  end

  def payment(user, booking)
    @user = user  # Instance variable => available in view
    @booking = booking
    mail(to: @user.email, subject: 'Cap Vauban - Paiement reçu')
    # This will render a view in `app/views/user_mailer`!
  end

  def cancelled_booking(user, booking)
    @user = user  # Instance variable => available in view
    @booking = booking
    mail(to: @user.email, subject: 'Cap Vauban - #{t("mailer.cancelled_booking_subject")}')
    # This will render a view in `app/views/user_mailer`!
  end

  def admin_new_booking(user, booking)
    @user = user  # Instance variable => available in view
    @booking = booking
    mail(to: "francois@cap-vauban.com, lecapvauban@gmail.com", subject: 'Nouvelle demande de réservation!')
    # This will render a view in `app/views/user_mailer`!
  end
end
