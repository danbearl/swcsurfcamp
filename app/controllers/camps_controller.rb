class CampsController < ApplicationController
  expose(:camps)
  expose(:camp)
  expose(:options) {
    [ 'weekday',
      'weekend']
  }

  def create
    if camp.save
      redirect_to camps_path, notice: "Camp created"
    else
      render 'new'
    end
  end

  def index
  end

  def show
  end
end
