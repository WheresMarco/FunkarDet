class RemoveUserIdFromGroups < ActiveRecord::Migration
  def self.up
    remove_column :groups, :user_id
  end

  def self.down
    add_column :groups, :user_id, :integer
  end
end
