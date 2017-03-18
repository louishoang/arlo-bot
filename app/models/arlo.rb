class Arlo
  include RestClientHelper
  include FolderHelper
  attr_accessor :body, :cookies, :headers, :username, :password, :token

  def initialize
    @username = ENV["ARLO_USERNAME"]
    @password = ENV["ARLO_PASSWORD"]
    @body = login
    @token = body["data"]["token"]
  end

  def login
    response = post(url: 'https://arlo.netgear.com/hmsweb/login',
                    payload: { email: username, password: password },
                    headers: login_headers)

    raise ArloException::ClientApiError unless response.code == 200
    json response: response
  end

  def get_library(from_date: nil, to_date: nil)
    from_date ||= DateTime.now.to_s(:basic)
    to_date ||= from_date

    response = post(url: 'https://arlo.netgear.com/hmsweb/users/library',
                    payload: { dateFrom: from_date, dateTo: to_date },
                    headers: default_headers)

    raise ArloException::ClientApiError unless response.code == 200

    json(response: response)['data'].map { |item| MotionRecord.new(data: item) }.select(&:valid?)
  end

  def download(record:)
    response = RestClient.get(record.content_url)

    raise ArloException::ClientApiError unless response.code == 200

    directory = find_or_create_folder(time_frame: record.created_date)
    file = Rails.root.join(directory, "#{record.name}.mp4")

    if File.exist?(file)
      puts 'File existed'
      return
    end

    File.open(file, 'w') do |f|
      f.write response.body.force_encoding('utf-8')
    end
  end

  private

  def login_headers
    {
      DNT:'1',
      Host: 'arlo.netgear.com',
      Referer: 'https://arlo.netgear.com/',
      content_type: 'application/json'
    }
  end

  def default_headers
    login_headers.merge({ Authorization: token })
  end
end