class CreateHashTags < ActiveRecord::Migration
  def change
    create_table :hash_tags do |t|

      t.timestamps
    end
  end
end
