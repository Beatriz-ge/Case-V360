class TasksController < ApplicationController
  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @task = @todo_list.tasks.build(task_params)
    
    if @task.save
      redirect_to @todo_list
    else
      render "todo_lists/show", status: :unprocessable_entity
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update(completed: !@task.completed)
    redirect_to todo_list_path(@task.todo_list)
  end

  def destroy
    task = Task.find(params[:id])
    todo_list = task.todo_list
    task.destroy
    redirect_to todo_list_path(todo_list)
  end

  private

  def task_params
    params.require(:task).permit(:title, :completed)
  end
end
