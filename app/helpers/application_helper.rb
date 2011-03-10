module ApplicationHelper
  
  def get_markdown_html(text)
      markdown = RDiscount.new(text)
      markdown.to_html.html_safe
  end
end
