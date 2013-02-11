class PagesController < ApplicationController

  expose(:pages)
  expose(:page, finder: :find_by_slug, finder_parameter: :slug)
  expose(:new_page, model: Page)

  # Move this to the ApplicationController if you want to have
  # the navigation in your Application Layout
  expose(:page_slugs ) { Page.select(:slug).map(&:slug) }

  def create
    if new_page.save
      redirect_to slug_path(new_page.slug)
    else
      render 'new'
    end
  end

  def update
    if page.save
      redirect_to slug_path(page.slug)
    else
      render 'edit'
    end
  end

  def destroy
    page.destroy
    redirect_to :root, message: "#{page.name} was deleted."
  end

end
