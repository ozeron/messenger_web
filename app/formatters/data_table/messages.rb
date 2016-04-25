module DataTable
  class Messages
    delegate :params, :truncate, :h, :t, :link_to, :number_to_currency, :edit_message_url,
             to: :@view

    def initialize(view)
      @view = view
    end

    def as_json(params = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: messages.count,
        iTotalDisplayRecords: messages.size,
        aaData: data
      }
    end

    private

    def data
      messages.map do |message|
        [
          message.id,
          link_to(message.title, message),
          truncate(ERB::Util.h(message.content), length: 300),
          message.tags.map(&:name).join('; '),
          message.pic1,
          link_to(t('edit'), edit_message_url(message)),
          link_to(t('destroy'), message, method: :delete, data: { confirm: t('confirmation') })
        ]
      end
    end

    def messages
      @messages ||= fetch_messages
    end

    def fetch_messages
      messages = Message.includes_tags.order("#{sort_column} #{sort_direction}")
      messages = messages.page(page).per(per_page)
      if params[:sSearch].present?
        messages = messages.search(params[:sSearch])
      end
      messages
    end

    def page
      params[:iDisplayStart].to_i / per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w(id title content)
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
    end
  end
end
