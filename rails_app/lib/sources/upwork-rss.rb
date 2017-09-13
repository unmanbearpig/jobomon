require_relative 'upwork-rss/fetcher'
require_relative 'upwork-rss/parser'

module Sources
  class UpworkRSS
    def self.fetch(url)
      response = fetcher.fetch(url)

      unless response.success?
        return raise_response_error(response, url)
      end

      parser.parse_feed response.body
    end

    def self.raise_response_error(response, url)
      if looks_like_captcha?(response)
        raise GotCaptcha.new("got captcha while trying to fetch #{url}")
      else
        raise ErrorServerResponse.new("Server returned error \"#{response.status} #{response.reason_phrase}\" url: #{url}")
      end
    end

    def self.looks_like_captcha?(response)
      return false unless response.status == 403
      return false unless response.body.include?('captcha')
      return false unless response.body.include?('Cloudflare Ray ID')
      true
    end

    def self.fetcher
      Fetcher
    end

    def self.parser
      Parser
    end

    class Error < StandardError; end
    class GotCaptcha < Error; end
    class ErrorServerResponse < Error; end
  end
end
