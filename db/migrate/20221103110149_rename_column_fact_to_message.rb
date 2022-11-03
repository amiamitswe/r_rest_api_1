class RenameColumnFactToMessage < ActiveRecord::Migration[7.0]
  def change
    remove_column :facts, :fact, :string
    add_column :facts, :message, :string
  end
end
