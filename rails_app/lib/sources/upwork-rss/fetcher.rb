require 'faraday_adapter_socks'

module Sources
  class UpworkRSS
    class Fetcher
      def self.fetch(url)
        connection(url).get
      end

      def self.proxy_settings
        url = ENV['PROXY_URL']
        return nil unless url

        { uri: URI.parse(url) }
      end

      def self.connection(url)
        Faraday.new(url: url, proxy: proxy_settings) do |conn|
          conn.request :url_encoded
          conn.use FaradayMiddleware::FollowRedirects, limit: 3
          conn.adapter :net_http_socks
        end
      end
    end
  end
end
