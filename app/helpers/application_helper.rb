module ApplicationHelper

  #returns the full title of the page
  def full_title(page_title = '')
    base_title = "TODO Manager App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
