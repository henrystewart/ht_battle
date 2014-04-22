class Battle < ActiveRecord::Base
  attr_accessible :name, :brand_1_hashtag, :brand_1_count, :brand_2_hashtag, :brand_2_count
  @@count = 1

  def self.set_name(brand_1,brand_2)
    this.name = "#{brand_1} " + " vs. " + "#{brand_2}"
  end

end
