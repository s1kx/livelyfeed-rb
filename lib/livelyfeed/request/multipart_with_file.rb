require 'faraday'

module Livelyfeed
  module Request
    class MultipartWithFile < Faraday::Middleware
      CONTENT_TYPE = 'Content-Type'

      def call(env)
        env[:body].each do |key, value|
          if value.respond_to?(:to_io)
            env[:body][key] = Faraday::UploadIO.new(value, mime_type(value.path), value.path)
          elsif value.respond_to?(:tempfile)
            env[:body][key] = Faraday::UploadIO.new(value.tempfile.path, value.content_type, value.original_filename)
          end
        end if env[:body].is_a?(::Hash)
        @app.call(env)
      end

    private

      def mime_type(path)
        case path
        when /\.jpe?g/i
          'image/jpeg'
        when /\.gif$/i
          'image/gif'
        when /\.png$/i
          'image/png'
        when /\.mp4$/i
          'video/mp4'
        when /\.ogv$/i
          'video/ogg'
        else
          'application/octet-stream'
        end
      end

    end
  end
end