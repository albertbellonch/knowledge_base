module ApplicationHelper
  
  def get_markdown_html(text, options = {})
     markdown = RDiscount.new(text)
      html = markdown.to_html.html_safe
      unless options[:max].nil?
        html = truncate(html, :length => options[:max])
      end
      html
   end
end
