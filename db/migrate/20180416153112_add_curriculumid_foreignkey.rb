class AddCurriculumidForeignkey < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key(:curriculums, :camps)
  end
end
