class VkGroupsBoard < BasicBoard
  def app
    @app ||= current_user.vk_app
  end

  def groups
    if params[:query].blank?
      @groups ||= []
    else
      @groups ||= app.groups.search(q: params[:query], fields: %w(description members_count))
                  .fetch('items')
                  .map do |g|
                    g['members_count'] ||= 'unknown'
                    g['description'] ||= ''
                    g
                  end.map { |g| Hashie::Mash.new(**g.symbolize_keys) }
    end
  end

end
