module Paginate
  def search_paginate(params)
    search = metasearch params[:search]
    records = search.paginate params[:page]

    [search, records]
  end

  def next(params)
    search, records = search_paginate(params)
    records.last unless records.length != default_per_page
  end

  def paginate(page)
    page(page)
  end
end

ActiveRecord::Base.extend Paginate
