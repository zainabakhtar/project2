class RemoveColumnsInstructor < ActiveRecord::Migration[5.1]
  def change
    remove_column :instructors, :email, :string
  end
end
