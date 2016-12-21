class AddAdminCommentToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :admin_comment, :string
  end
end
