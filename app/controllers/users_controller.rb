class UsersController < ApplicationController

  expose(:user)
  
  def update
    if user.save
      redirect_to root_path
    else
      render 'edit'
    end
  end
end
