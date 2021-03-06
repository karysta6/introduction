class StoriesController < ApplicationController
  
  def index
    @current_user_stories = Story.where(user: current_user)
    @other_user_stories = Story.where.not(user: current_user).shuffle
    @guessed_stories = Story.joins(:guesses).where(guesses: {user: current_user})
  end
  
  def show
    @story = Story.find(params[:id])
  end

  def new
    @story = Story.new
    @scount = Story.where(user: current_user).count
    @gcount = Guess.where(user: current_user).count
  end
  
  def edit
    @story = Story.find(params[:id])
  end
 
  def create
    @story = Story.new(story_params)
    @scount = Story.where(user: current_user).count
    @gcount = Guess.where(user: current_user).count

    @story.user = current_user
    
    if @story.save
      redirect_to stories_path
    else
      render 'new'
    end
  end
  
  def update
    @story = Story.find(params[:id])
 
    if @story.update(story_params)
      redirect_to stories_path
    else
      render 'edit'
    end
  end
 
  private 
  def story_params
    params.require(:story).permit(:text)
  end

end
