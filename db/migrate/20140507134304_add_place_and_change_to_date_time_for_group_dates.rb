class AddPlaceAndChangeToDateTimeForGroupDates < ActiveRecord::Migration
  def change
    remove_column :group_dates, :from_date, :date
    remove_column :group_dates, :to_date, :date

    add_column :group_dates, :from_date, :datetime
    add_column :group_dates, :to_date, :datetime
    add_column :group_dates, :place, :string
  end
end
