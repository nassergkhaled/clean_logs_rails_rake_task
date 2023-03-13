class TaskController < ApplicationController
  def index
    # render ('new')
    @message = "Welcome to home page"
  end

  def new
    @number =params[:number]
    @string =params['string']
  end

  def edit
  end
end
