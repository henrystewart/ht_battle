class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.string :name
      t.string :brand_1_hashtag
      t.string :brand_1_count
      t.string :brand_2_hashtag
      t.string :brand_2_count
      t.timestamps
    end
  end
end
