class ChangeColumnToTasksPriority < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :priority, :integer, null: false, default: 0
  end
  def down 
    change_column :tasks, :priority, :integer, null: true, default: 0
  end
end
