require 'rails-html-sanitizer'

class SanitizeHTML
  def self.sanitizer
    Rails::Html::WhiteListSanitizer.new
  end

  def self.call(html)
    sanitizer.sanitize(html)
  end
end
