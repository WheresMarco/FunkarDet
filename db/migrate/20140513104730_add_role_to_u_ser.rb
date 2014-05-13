class AddRoleToUSer < ActiveRecord::Migration
  def change
    add_column :users, :organizer, :boolean
  end
end
