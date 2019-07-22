class AddAgeToAnimals < ActiveRecord::Migration[5.2]
  def change
    add_column :animals, :age, :string
  end
end
