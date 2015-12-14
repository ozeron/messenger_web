class Group
  class UpdateService < ::Service
    def perform!
      @object = board.group
      @result = object.update(filtered_group_params)
      object.taggings.each do |tagging|
        tagging.destroy if destroy_taggable_ids.include?(tagging.taggable_id.to_s)
      end
      object.update(taggings_count: object.taggings.size)
      object.reload if object.persisted?
      board.group.reload if object.persisted?
    end

    def filtered_group_params
      h = groups_params
      taggable_ids = object.taggings.map(&:taggable_id)
      if h.key?('taggings_attributes')
        deleted = h['taggings_attributes'].reject do |k, v|
          taggable_ids.include?(k.to_i) && v['_destroy'] != '1'
        end
        h['taggings_attributes'] = Hash[deleted]
      end
      h
    end

    def destroy_taggable_ids
      taggings_params.values
        .select { |h| h['_destroy'] == '1' }
        .map { |h| h['taggable_id'] }
    end

    def groups_params
      params.require(:group).permit(:name,
                                    taggings_attributes: [:taggable_id,
                                                          :taggable_type,
                                                          :context,
                                                          :_destroy])
    end

    def taggings_params
      params.require(:group).require(:taggings_attributes)
    end
  end
end
