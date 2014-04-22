class BattleController < ApplicationController

  def index
  end

  def create
    # create object with passed params, tell db object is running
    @battle = Battle.new(params[:battle])
    @battle.running = true

    puts params[:battle]
    # current user object is this new object
    # current_user.running_battle_id = @battle
    
    # enqueue
    # Resque.enqueue(HashtagBattle,1)
    
    
    # save everyone
    @battle.save!
    # current_user.save!
    

    Resque.enqueue(HashtagBattle, 1, params[:battle][:brand_1_hashtag], params[:battle][:brand_2_hashtag])
    #puts "params!!!"
    #puts params[:battle]
    # redirect to home
    redirect_to :root
    
  end

  def show
    #@battle = Battle.where("battle_id = ?", params[:battle_id])
    @battle = Battle.find(params[:id])

  end

  def new
  end

  def time

  end

  def end
    # current user object set to nil
    #current_user.running_battle_id = nil

    # dequue everything from resque
    # Resque.dequeue( process... )

    # tell db object is not running
    @battle = Battle.find_by_id(1)
    @battle.running = false
     
    Resque.queues.each do |q|
      Resque.redis.del "queue:#{q}"
    end

    # do not destroy battle, just save
    @battle.save!
    #current_user.save!

    # redir to home
    redirect_to :root
  end

end
