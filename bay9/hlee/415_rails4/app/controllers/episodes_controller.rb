class EpisodesController < ApplicationController
  before_filter :load_episode, only: [:show, :edit, :update, :destroy]
  caches_page :index

  def index
    @episodes = Episode.published.where(pro: false)
  end

  def show
  end

  def new
    @episode = Episode.new
  end

  def edit
  end

  def create
    @episode = Episode.new(episode_params)
    if @episode.save
      redirect_to @episode, notice: 'Episode was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @episode.update_attributes(params[:episode])
      redirect_to @episode, notice: 'Episode was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @episode.destroy
    redirect_to episodes_url, notice: 'Episode was successfully destroyed.'
  end

private

  def episode_params
    params.require(:episode).permit(:description, :name, :seconds, :published_on, :timecode)
  end

  def load_episode
    @episode = Episode.find(params[:id])
  end
end
