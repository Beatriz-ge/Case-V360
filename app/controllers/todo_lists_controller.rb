class TodoListsController < ApplicationController
  def index
    @lists = TodoList.all
  end

  def show
    @list = TodoList.find(params[:id])
    @task = Task.new
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

  def show
    @list = TodoList.find(params[:id])
    @task = Task.new

    @total_tasks = @list.tasks.count
    @completed_tasks = @list.tasks.where(completed: true).count
    @pending_tasks = @total_tasks - @completed_tasks

    @progress = @total_tasks.zero? ? 0 : (@completed_tasks.to_f / @total_tasks * 100).round
  end

  private

  def list_params
    params.require(:todo_list).permit(:title)
  end
end

