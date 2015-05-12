class Recommender::Support::Request
  class << self
    def makeSecureGet(url, params)
      uri = URI.parse(url)
      uri.query = URI.encode_www_form(params)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(uri.request_uri)
      http.request(request).body
    end
  end
end
