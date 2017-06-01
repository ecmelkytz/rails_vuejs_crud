class AddEditableToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :editable, :boolean, default: :false
  end
end
