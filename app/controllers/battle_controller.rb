class BattleController < ApplicationController

  def index
    @battle = Battle.new
    #battle1 = HashtagBattle.new
    Resque.enqueue(HashtagBattle,1)
    # @count = HashtagBattle.counter
    # fork {
    #HashtagBattle.get_stream()
    # }
  end

  def new
    render :text => HashtagBattle.counter
  end

end
