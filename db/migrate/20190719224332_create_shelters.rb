class CreateShelters < ActiveRecord::Migration[5.2]
  def change
    create_table :shelters do |t|

      t.string 'name'
      t.string 'source_id'
      t.string 'url'
      t.string 'state'
      t.string 'city'
      t.string 'address'

      t.timestamps
    end
  end
end