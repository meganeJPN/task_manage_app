class ChangeColumnToTasksStatus < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :status, :integer, null: false, default: 0
  end
  def down 
    change_column :tasks, :status, :integer, null: true, default: 0
  end
end
