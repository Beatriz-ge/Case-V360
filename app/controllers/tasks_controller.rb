class TasksController < ApplicationController
  before_action :set_todo_list, only: %i[create edit update]
  before_action :set_task, only: %i[edit update toggle destroy]

  def create
    @task = @todo_list.tasks.build(task_params)

    if @task.save
      redirect_to @todo_list
    else
      render "todo_lists/show", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @todo_list, notice: "Tarefa atualizada!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle
    @task.update(completed: !@task.completed)
    redirect_to todo_list_path(@task.todo_list)
  end

  def destroy
    todo_list = @task.todo_list
    @task.destroy

    redirect_to todo_list_path(todo_list), notice: "Tarefa excluída!"
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title)
  end
end
