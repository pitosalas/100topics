# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Prepares a clever link excerpt, like
  # http://www.some.com/.../my.xml from http://www.some.com/long/folder/my.xml
  def link_excerpt(link)
    link.gsub(/^([a-z]+:\/\/[^\/]+\/).{4,}(\/[^\/]+)$/, '\1...\2')
  end

  def button_to_remote(name, options = {}, html_options = {})  
    button_to_function(name, remote_function(options), html_options)
  end
end
