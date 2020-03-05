class TaskEntriesController < ApplicationController
  before_action :set_task_entry, only: [:show, :edit, :update, :destroy, :start_time, :stop_time]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :perform_authorization, only: [:show, :edit, :update, :destroy]
  
  # GET /task_entries
  # GET /task_entries.json
  def index  
    @tasks = Task.all
    if current_user != nil
      @task_entries = TaskEntry.joins(:task).where("tasks.user_id = ?", current_user.id)
    else
      redirect_to new_user_session_path
    end
  end

  # GET /task_entries/1
  # GET /task_entries/1.json
  def show
  end

  # GET /task_entries/new
  def new
    @task_entry = TaskEntry.new
  end

  # GET /task_entries/1/edit
  def edit
  end


  def start_time
    respond_to do |format|
      if @task_entry.update(start_time: Time.zone.now)
        format.html { redirect_to task_entries_path, notice: 'Timer was started.'}
      else
        format.html { redirect_to task_entries_path, notice: 'Timer failed to start.'}
      end
    end  
  end

  def stop_time
    respond_to do |format|

      prev_duration = @task_entry.duration
      if prev_duration.nil?
        prev_duration = 0
      end

      duration = ((Time.zone.now - @task_entry.start_time) / 60).to_i

      if @task_entry.update(start_time: nil, duration: prev_duration + duration)
        format.html { redirect_to task_entries_path, notice: 'Timer was stopped.'}
      else
        format.html { redirect_to task_entries_path, notice: 'Timer failed to stop.'}
      end
    end  
  end

  # POST /task_entries
  # POST /task_entries.json
  def create
    @task_entry = TaskEntry.new(task_entry_params)

    respond_to do |format|
      if @task_entry.save
        format.html { redirect_to @task_entry, notice: 'Task entry was successfully created.' }
        format.json { render :show, status: :created, location: @task_entry }
      else
        format.html { render :new }
        format.json { render json: @task_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_entries/1
  # PATCH/PUT /task_entries/1.json
  def update
    respond_to do |format|
      if @task_entry.update(task_entry_params)
        format.html { redirect_to @task_entry, notice: 'Task entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_entry }
      else
        format.html { render :edit }
        format.json { render json: @task_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_entries/1
  # DELETE /task_entries/1.json
  def destroy
    @task_entry.destroy
    respond_to do |format|
      format.html { redirect_to task_entries_url, notice: 'Task entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_entry
      @task_entry = TaskEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_entry_params
      params.require(:task_entry).permit(:task_id, :duration, :note, :start_time)
    end

    # check to make sure that the user can only see his own tasks_entries
    def perform_authorization
      if @task_entry.task.user_id != current_user.id
        redirect_to task_entries_path, notice: 'Not Authorized to View!'
      end
    end
end
