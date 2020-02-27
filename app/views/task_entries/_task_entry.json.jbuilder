json.extract! task_entry, :id, :task_id, :duration, :note, :start_time, :created_at, :updated_at
json.url task_entry_url(task_entry, format: :json)
