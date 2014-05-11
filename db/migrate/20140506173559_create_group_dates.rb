class CreateGroupDates < ActiveRecord::Migration
  def change
    create_table :group_dates do |t|
      t.references :group, index: true
      t.string :name
      t.date :from_date
      t.date :to_date
      t.string :description

      t.timestamps
    end
  end
end
