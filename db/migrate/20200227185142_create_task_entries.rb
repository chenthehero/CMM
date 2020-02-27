class CreateTaskEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :task_entries do |t|
      t.references :task, null: false, foreign_key: true
      t.time :duration
      t.text :note
      t.datetime :start_time

      t.timestamps
    end
  end
end
