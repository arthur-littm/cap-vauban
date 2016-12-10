class UserMailerPreview < ActionMailer::Preview
  def booking_test
    user = User.first
    UserMailer.new_booking(user)
  end
end
