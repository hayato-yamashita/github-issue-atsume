module ApplicationHelper
  def empty_message
    tag.div(class: 'message is-warning') do
      tag.div(class: 'message-body') { 'There is no data to display.' }
    end
  end
end
