class Yoda < Base
  def translate
    parse response
  end

  def response
    RestClient::Request.execute(method: :post,
                                url: base_uri,
                                payload: {d: 'yoda',
                                          w: @message})
  end

  def parse(result)
    page = Nokogiri::HTML(result)
    page.search("blockquote").last.text
  end
end
