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

  private

  def list_params
    params.require(:todo_list).permit(:title)
  end
end

