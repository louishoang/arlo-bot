class MotionRecord
  attr_accessor :device_id, :created_date, :name, :recorded_reason, :created_by,
                :content_url, :thumbnail, :duration, :content_type

  def initialize(data:)
      @device_id = data['deviceId']
      @content_type = data['contentType']
      @created_date = data['createdDate']
      @name = data['name']
      @recorded_reason = data['reason']
      @created_by = data['createdBy']
      @content_url = data['presignedContentUrl']
      @thumbnail = data['presignedThumbnailUrl']
      @duration = data['mediaDurationSecond']
  end

  def valid?
    @content_type == 'video/mp4' && content_url.present?
  end

  def humanized_file_name
    time = Time.at(name.to_i / 1000)
    time.to_s(:time_extended).tr(':', '-')
  rescue
    name
  end
end
