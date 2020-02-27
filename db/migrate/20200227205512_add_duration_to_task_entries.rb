class AddDurationToTaskEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :task_entries, :duration, :integer
  end
end
