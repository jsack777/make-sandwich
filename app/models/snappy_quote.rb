require 'net/http'

class SnappyQuote

  def self.get_one
    url = URI.parse('http://www.iheartquotes.com/api/v1/random')
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    res.body.gsub(/\[.*$/x, '')
  end

end