class AddPictureInstructor < ActiveRecord::Migration[5.1]
  def change
    add_column :instructors, :picture, :string
  end
end
