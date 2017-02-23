module Sources
  class UpworkRSS
    class Fetcher
      def self.fetch(url)
        connection(url).get
      end

      def self.connection(url)
        Faraday.new(url: url) do |conn|
          conn.use FaradayMiddleware::FollowRedirects, limit: 3
          conn.adapter :net_http
        end
      end
    end
  end
end
