class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_booking.subject
  #
  def new_booking(user)
    @user = user  # Instance variable => available in view

    mail(to: @user.email, subject: 'Cap Vauban - Booking')
    # This will render a view in `app/views/user_mailer`!
  end
end
