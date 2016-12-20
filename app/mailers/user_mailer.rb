class UserMailer < ApplicationMailer

  def french_new_booking(user, booking)
    @user = user  # Instance variable => available in view
    @booking = booking
    mail(to: @user.email, subject: 'Cap Vauban - Réservation confirmée')
    # This will render a view in `app/views/user_mailer`!
  end

  def english_new_booking(user, booking)
    @user = user  # Instance variable => available in view
    @booking = booking
    mail(to: @user.email, subject: 'Cap Vauban - Booking confirmation')
    # This will render a view in `app/views/user_mailer`!
  end

  def french_cancelled_booking(user, booking)
    @user = user  # Instance variable => available in view
    @booking = booking
    mail(to: @user.email, subject: 'Cap Vauban - Réservation annulée')
    # This will render a view in `app/views/user_mailer`!
  end

  def english_cancelled_booking(user, booking)
    @user = user  # Instance variable => available in view
    @booking = booking
    mail(to: @user.email, subject: 'Cap Vauban - Booking cancelled')
    # This will render a view in `app/views/user_mailer`!
  end

  def payment(user, booking)
    @user = user  # Instance variable => available in view
    @booking = booking
    mail(to: "francois@cap-vauban.com, lecapvauban@gmail.com", subject: 'Cap Vauban - Paiement reçu')
    # This will render a view in `app/views/user_mailer`!
  end

  def admin_new_booking(user, booking)
    @user = user  # Instance variable => available in view
    @booking = booking
    mail(to: "francois@cap-vauban.com, lecapvauban@gmail.com", subject: 'Nouvelle demande de réservation!')
    # This will render a view in `app/views/user_mailer`!
  end
end
