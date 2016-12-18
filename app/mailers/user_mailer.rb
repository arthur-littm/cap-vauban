class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_booking.subject
  #
  def new_booking(user, booking)
    @user = user  # Instance variable => available in view
    @booking = booking
    mail(to: @user.email, subject: 'Cap Vauban - Réservation confirmée')
    # This will render a view in `app/views/user_mailer`!
  end

  def cancelled_booking(user, booking)
    @user = user  # Instance variable => available in view
    @booking = booking
    mail(to: @user.email, subject: 'Cap Vauban - Réservation annulée')
    # This will render a view in `app/views/user_mailer`!
  end

  def admin_new_booking(user, booking)
    @user = user  # Instance variable => available in view
    @booking = booking
    mail(to: "francois@cap-vauban.com, lecapvauban@gmail.com", subject: 'Nouvelle demande de réservation!')
    # This will render a view in `app/views/user_mailer`!
  end

end
