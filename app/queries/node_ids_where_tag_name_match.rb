class NodeIdsWhereTagNameMatch
  def self.query(string)
    ActiveRecord::Base.connection.execute(sql(string)).map { |h| h.fetch('id')}
  end

  def self.sql(string)
    <<-SQL
SELECT DISTINCT nodes.id
FROM taggings
JOIN nodes ON taggable_id = nodes.id
JOIN tags ON tag_id = tags.id
WHERE (tags.name ILIKE '%#{string}%' AND taggable_type = 'Node')
SQL
  end
end
