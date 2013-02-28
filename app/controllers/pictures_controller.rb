class PicturesController < ApplicationController

  before_filter :require_user, except: [:gallery]

  expose(:pictures) { Picture.paginate(page: params['page'], per_page: 20) }
  expose(:picture)

  def create
    @picture = Picture.new(params[picture])
    if picture.save
      redirect_to pictures_path, notice: 'Picture successfully uploaded.'
    else
      render 'new'
    end
  end

  def update
    if picture.save
      redirect_to pictures_path, notice: 'Picture successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    picture.destroy
    redirect_to pictures_path, notice: 'Picture successfully deleted.'
  end

end
