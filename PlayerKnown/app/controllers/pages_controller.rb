class PagesController < ApplicationController
  def index
	@search = index.search(params[:search])
  end
  

end
