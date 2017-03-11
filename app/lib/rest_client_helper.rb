require 'rest-client'

module RestClientHelper
  DEFAULT_TIME_OUT = 20

  def get(url:, payload: {}, headers: {})
    make_req(method: :get, url: url, payload: payload, headers: headers)
  end

  def post(url:, payload: {}, headers: {})
    make_req(method: :post, url: url, payload: payload, headers: headers)
  end

  def put(url:, payload: {}, headers: {})
    make_req(method: :put, url: url, payload: payload, headers: headers)
  end

  def make_req(method: ,url: , payload:, headers:)
    RestClient::Request.execute(method: method,
                                url: url,
                                payload: payload.to_json,
                                headers: headers,
                                timeout: DEFAULT_TIME_OUT)
  end

  def json(response:)
    JSON.parse(response)
  end
end
