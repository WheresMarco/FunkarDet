class RenameCreationDateToCreationDate < ActiveRecord::Migration
  def change
    rename_column :groups, :creationDate, :creation_date
  end
end
