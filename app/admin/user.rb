ActiveAdmin.register User do
menu priority: 2

  form do |f|
    f.inputs "Identity" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
    end
    f.inputs "Admin" do
      f.input :admin
    end
    f.actions
  end

  permit_params :email, :first_name, :last_name, :phone, :sign_in_count, :last_sign_in_at, :last_sign_in_ip, :admin
end
