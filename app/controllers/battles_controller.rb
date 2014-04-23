class BattlesController < ApplicationController

  def index
  end

  def create
    # create object with passed params, tell db object is running
    @battle = Battle.new(params[:battle])
    @battle.running = true

    puts params[:battle]

    # save everyone
    @battle.save!

    # Enqueue to Resque
    Resque.enqueue(HashtagBattle, @battle.id, params[:battle][:brand_1_hashtag], params[:battle][:brand_2_hashtag])


    # redirect to battle, "show" battle
    redirect_to battle_path(@battle.id)
    
  end

  def show
    @battle = Battle.find(params[:id])
  end

  def new
  end

  def time
  end

  def present
    @battle = Battle.where("id = ?", params[:battle_id])

    respond_to do |format|
      format.js
    end
    # redirect_to battle_path(@battle.id)
  end

  def end
    # tell db object is not running

    battle = Battle.find_by_id(params[:battle_id])
    battle.running = false

    Battle.transaction do
      battle.save!
    end

    # dequeue everything from resque
    Resque.queues.each do |q|
      Resque.redis.del "queue:#{q}"
    end

    # redir to home
    redirect_to :root
  end

end
