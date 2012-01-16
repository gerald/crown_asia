module ApplicationHelper

  def loader(id = nil)
    image_tag "loader.gif", :id => "#{id.nil? ? 'loader' : id}", :style => "display:none"
  end

end
