class Battle < ActiveRecord::Base
  attr_accessible :name, :brand_1_hashtag, :brand_1_count, :brand_2_hashtag, :brand_2_count
  @@count = 1

  def self.inc_count 
    @@count += 1
  end

end
