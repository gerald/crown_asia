module ApplicationHelper

  def loader(id = nil)
    image_tag "loader.gif", :id => "#{id.nil? ? 'loader' : id}", :style => "display:none"
  end
  
  def selected_menu(selected)
    "active" if controller_name == selected
  end

end
