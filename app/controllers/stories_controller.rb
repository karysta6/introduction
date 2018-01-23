class StoriesController < ApplicationController
  def index
    @current_user_stories = Story.where(user: current_user)
    @other_user_stories = Story.where.not(user: current_user)
  end
  
  def show
    @story = Story.find(params[:id])
  end

  def new
    @story = Story.new
  end
  
  def create
    @story = Story.new(story_params)
    @story.user = current_user
    
    if @story.save
      redirect_to @story
    else
      render 'new'
    end
  end
  
  private 
  def story_params
    params.require(:story).permit(:text)
  end

end
