module VK
  class ApplicationDecorator
    attr_reader :app

    def initialize(app)
      @app = app
    end

    def attach_document(path, type)
      hash = upload_doc(path, type)
      "doc#{hash.fetch('owner_id')}_#{hash.fetch('id')}"
    end

    def upload_doc(path, type)
      url = default_doc_upload_server
      files = { file: [path, type] }
      hash = app.upload(url, files)
      app.docs.save(hash)[0]
    end

    def default_doc_upload_server
      app.docs.getUploadServer.fetch('upload_url')
    end

    def default_photo_upload_server
      hash = photos.getUploadServer('album_id' => default_album_id)
      hash.fetch('upload_url')
    end

    def default_album_id
      hash = app.photos.getAlbums
      if hash['count'] != 0
        hash['items'][0].fetch('id')
      else
        create_album('my.')
      end
    end

    def create_album(title)
      result = app.photos.createAlbum('title' => title, 'comments_disabled' => 1)
      result.fetch('id')
    end

    def method_missing(method, *args, &block)
      @app.send(method, *args, &block)
    end
  end
end
