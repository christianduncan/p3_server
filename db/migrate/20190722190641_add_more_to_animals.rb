class AddMoreToAnimals < ActiveRecord::Migration[5.2]
  def change
    add_column :animals, :gender, :string
    add_column :animals, :size, :string
  end
end
