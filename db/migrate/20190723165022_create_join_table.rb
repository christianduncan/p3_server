class CreateJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :animals do |t|
       t.index :user_id
       t.index :animal_id
    end
  end
end
