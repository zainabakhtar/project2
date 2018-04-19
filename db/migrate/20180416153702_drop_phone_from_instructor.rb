class DropPhoneFromInstructor < ActiveRecord::Migration[5.1]
  def change
    remove_column :instructors, :phone
    remove_column :instructors, :email
  end
end
