ActiveAdmin.register User do
  index do
    column :first_name
    column :last_name
    column :email
    column :gender
    column :phone_number
    column :street_address
    column :city
    column :province
    column :postal_code
    column :country
    column 'Join Date', :created_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :gender
      f.input :phone_number
      f.input :street_address
      f.input :city
      f.input :province
      f.input :postal_code
      f.input :country, as: :string
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit user: [:first_name, :last_name, :gender, :email, :phone_number, :street_address, :city, :province, :postal_code, :country, :password, :password_confirmation]
    end
  end
end
