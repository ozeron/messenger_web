json.array!(b.groups) do |group|
  json.extract! group, :id, :name, :screen_name, :type, :members_count, :description
  json.set! :photo, group.photo_100
end
