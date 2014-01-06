class AddDefaultRoleToAdminUser < ActiveRecord::Migration
  def change
    change_column :admin_users, :role, :string, default: 'jury'
  end
end
