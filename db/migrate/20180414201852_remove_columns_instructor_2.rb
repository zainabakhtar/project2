class RemoveColumnsInstructor2 < ActiveRecord::Migration[5.1]
  def change
    remove_column :instructors, :phone, :string
  end
end
