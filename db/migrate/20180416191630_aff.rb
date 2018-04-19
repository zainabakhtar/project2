class Aff < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key(:users, :families)
  end
end
