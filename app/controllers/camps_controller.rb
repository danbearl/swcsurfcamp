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

  def update
    if camp.save
      redirect_to camps_path, notice: "Camp updated."
    else
      render 'edit'
    end
  end

  def destroy
    camp.destroy
    redirect_to camps_path, notice: "Camp deleted."
  end

end
