class VkGroupsBoard < BasicBoard
  def app
    @app ||= current_user.vk_app
  end

  def groups
    if params[:query].blank?
      @groups ||= []
    else
      raw = app.groups.search(q: params[:query], fields: %w(description members_count))
                .fetch('items')
      ids = raw.map { |h| h['id'] }
      request = app.groups.get_by_id(group_ids: ids, fields: ['description', 'can_post'])
      records = request.map do |g|
                    g['members_count'] ||= 'unknown'
                    g['description'] ||= ''
                    g
                  end
      filtered = records.select { |h| h['can_post'] == 1 && h['is_closed'] == 0}
      @groups = filtered.map { |g| Hashie::Mash.new(**g.symbolize_keys) }
    end

  end

end
