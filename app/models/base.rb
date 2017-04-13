class Base
  def initialize(message, dialect)
    @message = message
    @dialect = dialect
  end

  def base_uri
    'http://www.degraeve.com/cgi-bin/babel.cgi'
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
    page = Nokogiri::HTML(result)
    page.search("blockquote").last.text
  end
end
