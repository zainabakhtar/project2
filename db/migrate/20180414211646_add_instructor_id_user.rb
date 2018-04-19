class AddInstructorIdUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :instructor_id, :integer
  end
end
