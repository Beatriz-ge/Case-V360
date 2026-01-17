class TodoListsController < ApplicationController
  before_action :set_list, only: %i[show edit update destroy]

  def index
    @lists = TodoList.all
  end

  def show
    @task = Task.new
    set_task_stats
  end

  def new
    @list = TodoList.new
  end

  def create
    @list = TodoList.new(list_params)

    if @list.save
      redirect_to @list
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @list.update(list_params)
      redirect_to @list, notice: "Lista atualizada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to todo_lists_path
  end

  private

  def set_list
    @list = TodoList.find(params[:id])
  end

  def list_params
    params.require(:todo_list).permit(:title)
  end

  def set_task_stats
    @total_tasks = @list.tasks.count
    @completed_tasks = @list.tasks.where(completed: true).count
    @pending_tasks = @total_tasks - @completed_tasks
    @progress = @total_tasks.zero? ? 0 : (@completed_tasks.to_f / @total_tasks * 100).round
  end
end
