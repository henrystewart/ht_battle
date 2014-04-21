class BattleController < ApplicationController

  def index
    HashtagBattle.get_stream()
  end

end
