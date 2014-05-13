class CreateGroupMembers < ActiveRecord::Migration
  def change
    create_table :group_members do |t|
      t.references :group, index: true
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
