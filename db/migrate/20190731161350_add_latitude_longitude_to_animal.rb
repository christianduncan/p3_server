class AddLatitudeLongitudeToAnimal < ActiveRecord::Migration[5.2]
  def change
    add_column :animals, :latitude, :float
    add_column :animals, :longitude, :float
  end
end
