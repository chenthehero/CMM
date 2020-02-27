require "application_system_test_case"

class TaskEntriesTest < ApplicationSystemTestCase
  setup do
    @task_entry = task_entries(:one)
  end

  test "visiting the index" do
    visit task_entries_url
    assert_selector "h1", text: "Task Entries"
  end

  test "creating a Task entry" do
    visit task_entries_url
    click_on "New Task Entry"

    fill_in "Duration", with: @task_entry.duration
    fill_in "Note", with: @task_entry.note
    fill_in "Start time", with: @task_entry.start_time
    fill_in "Task", with: @task_entry.task_id
    click_on "Create Task entry"

    assert_text "Task entry was successfully created"
    click_on "Back"
  end

  test "updating a Task entry" do
    visit task_entries_url
    click_on "Edit", match: :first

    fill_in "Duration", with: @task_entry.duration
    fill_in "Note", with: @task_entry.note
    fill_in "Start time", with: @task_entry.start_time
    fill_in "Task", with: @task_entry.task_id
    click_on "Update Task entry"

    assert_text "Task entry was successfully updated"
    click_on "Back"
  end

  test "destroying a Task entry" do
    visit task_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Task entry was successfully destroyed"
  end
end
