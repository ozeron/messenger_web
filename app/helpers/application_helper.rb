module ApplicationHelper
  def link_to_add_fields(name, f, association, board)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |b|
      render(association.to_s.singularize + '_fields', f: b)
    end
    link_to(name, '#', class: 'btn btn-default add_fields', data: {id: id, fields: fields.gsub("\n", "")})
  end
end
