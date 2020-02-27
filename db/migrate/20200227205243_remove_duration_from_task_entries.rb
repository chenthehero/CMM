class RemoveDurationFromTaskEntries < ActiveRecord::Migration[6.0]
  def change

    remove_column :task_entries, :duration, :time
  end
end
