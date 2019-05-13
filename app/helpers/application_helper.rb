module ApplicationHelper
  def empty_message
    content_tag(:div, class: 'message is-warning') do
      content_tag(:div, class: 'message-body') { 'There is no data to display.' }
    end
  end
end
