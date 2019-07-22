class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|

      t.string :name
      t.string :url
      t.string :source_id
      t.string :imageURL
      t.string :description
      t.string :email
      t.string :phone
      t.string :address1
      t.string :city
      t.string :state
      
      

      t.timestamps
    end
  end
end

