class TodoList < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :title, presence: true

  # Retorna o progresso da lista em porcentagem
  def progress
    return 0 if tasks.count.zero?
    (tasks.where(completed: true).count.to_f / tasks.count * 100).round
  end

  # Retorna true se todas as tasks estiverem concluídas
  def completed?
    progress == 100
  end
end
