class HashtagsController < ApplicationController

  def index
    @hashtags = Battle.where("id = ?", params[:battle_id])

  end
end
