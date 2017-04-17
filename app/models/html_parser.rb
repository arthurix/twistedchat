class HtmlParser
  def initialize(text)
    @text = text
  end

  def search(tag)
    result = @text.scan(/<#{tag}>(.*)<\/#{tag}>/m).flatten.first
    sanitize(result)
  end

  def sanitize(text)
    ActionView::Base.full_sanitizer.sanitize(text).strip
  end
end
