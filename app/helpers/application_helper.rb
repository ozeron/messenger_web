module ApplicationHelper
  def link_to_add_fields(name, f, association, board)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |b|
      render(association.to_s.singularize + '_fields', f: b)
    end
    link_to(name, '#', class: 'btn btn-default add_fields', data: {id: id, fields: fields.gsub("\n", "")})
  end

  def should_reload(status)
    status == 'pending' || status == 'in_progress'
  end

  def glyphicon_with_text(glyphicon, text)
    "<span class='glyphicon glyphicon-#{glyphicon}' aria-hidden='true'></span> #{text}".html_safe
  end

  def tag_badges(array)
    array.map { |a| "<span class='badge'>#{a}</span>" }.join(' ').html_safe
  end

  def nav_link(text, link)
    content_tag(:li, activity_class(link)) do
      link_to(text, link)
    end
  end

  def nav_links_for_list_group(text, link)
    recognized = Rails.application.routes.recognize_path(link)
    active_class = (recognized && request.url.include?(link)) ? 'active' : ''

    link_to(text, link, class: "list-group-item #{ active_class }")
  end

  def disabled_nav_link(text, link)
    content_tag(:li, :class => 'disabled') do
        link_to(text, link)
    end
  end

  def activity_class(link)
    {class: "active"} if current_page?(link) || new_or_edit(link)
  end

  def new_or_edit(link)
    ['/new','/edit'].any? { |x| request.path.include?(x) } &&
        request.path.include?(link)
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || "alert-#{flash_type.to_s}"
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end
end
