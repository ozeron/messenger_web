module DataTable
  class Nodes
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
          truncate(ERB::Util.h(node.description), length: 300),
          node.tag_list,
          link_to('Edit', edit_node_path(node)),
          link_to('Destroy', node, method: :delete, data: { confirm: 'Are you sure?' })
        ]
      end
    end

    def nodes
      @nodes ||= fetch_nodes
    end

    def fetch_nodes
      nodes = Node.order("#{sort_column} #{sort_direction}")
      nodes = nodes.page(page).per(per_page)
      if params[:sSearch].present?
        nodes = nodes.where('name ILIKE :search OR description ILIKE :search',
                            search: "%#{params[:sSearch]}%")
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
