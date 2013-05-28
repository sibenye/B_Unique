# Methods added to this helper will be available to all templates in the application.
require 'redcarpet'
module ApplicationHelper
  def markdown(text)
  options = {:hard_wrap => true, :filter_html => true, :autolink => true, :no_intraemphasis => true, :fenced_code => true, :gh_blockcode => true}
  mark = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
  mark.render(text)
  end
end
