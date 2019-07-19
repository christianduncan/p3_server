class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|

      t.string :name
      t.string :url
      t.string :source_id
      t.string :imageURL
      t.string :description
      
      

      t.timestamps
    end
  end
end

