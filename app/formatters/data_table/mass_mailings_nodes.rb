module DataTable
  class MassMailingsNodes
    delegate :params, :truncate, :h, :link_to, :number_to_currency, :edit_node_path,
             to: :@view

    def initialize(view)
      @view = view
    end

    def as_json(params = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Node.count,
        iTotalDisplayRecords: nodes.size,
        aaData: data
      }
    end

    private

    def data
      nodes.map do |node|
        [
          node.id,
          link_to(node.name, node),
          truncate(ERB::Util.h(node.description_human), length: 300),
          node.tags.map(&:name).join('; '),
          "<input type='checkbox' >"
        ]
      end
    end

    def nodes
      @nodes ||= fetch_nodes
    end

    def fetch_nodes
      nodes = Node.includes_tags.order("#{sort_column} #{sort_direction}")
      nodes = nodes.page(page).per(per_page)
      if params[:sSearch].present?
        nodes = nodes.search(params[:sSearch])
      end
      nodes
    end

    def page
      params[:iDisplayStart].to_i / per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w(id name description)
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
    end
  end
end
