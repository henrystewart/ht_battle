class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.string :name, :default => ""
      t.string :brand_1_hashtag, :null => false, :default => ""
      t.string :brand_2_hashtag, :null => false, :default => ""
      t.integer :brand_1_count, :null => false, :default => 0
      t.integer :brand_2_count, :null => false, :default => 0
      t.boolean :running, :null => false, :default => false
      t.boolean :started, :null => false, :default => false

      t.timestamps
    end
  end
end
