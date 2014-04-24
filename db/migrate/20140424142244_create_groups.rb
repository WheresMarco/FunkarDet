class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.date :creationDate

      t.timestamps
    end
  end
end
