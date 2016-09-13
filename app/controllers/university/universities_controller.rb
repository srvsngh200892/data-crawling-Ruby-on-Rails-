class University::UniversitiesController < ApplicationController

  def index
    @university_list = $university
    @res = Kaminari.paginate_array(@university_list, total_count: 311).page(params[:page]).per(10)
  end
end
