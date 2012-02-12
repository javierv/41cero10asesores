module Paginate
  def next(params)
    records = paginated_records(params)
    records.last unless records.length != default_per_page
  end

  def paginate(page)
    page(page)
  end

  def filtered_search(params)
    metasearch params[:search]
  end

  def paginated_records(params)
    filtered_search(params).paginate(params[:page])
  end
end

ActiveRecord::Base.extend Paginate
