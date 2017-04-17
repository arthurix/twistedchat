class Base
  def initialize(message, dialect)
    @message = message
    @dialect = dialect
  end

  def base_uri
    API[:base_uri]
  end

  def translate
    parse response
  end

  def response
    RestClient::Request.execute(method: :post,
                                url: base_uri,
                                payload: {d: @dialect,
                                          w: @message})
  end

  def parse(result)
    text = HtmlParser.new(result.body)
    text.search("blockquote")
  end
end
