desc 'Daily download all videos from Arlo account'

task :download_yesterday_videos => :environment do
  puts "Initializing"
  arlo = Arlo.new

  puts 'Logged in! Getting yesterday videos.'
  date = DateTime.now.yesterday.to_s(:basic)
  video_list = arlo.get_library(from_date: date, to_date: date)
  puts "There are #{video_list.size} videos in this period"

  video_list.each do |video|
    puts "Downloading video: #{video.name}"

    time_frame = DateTime.now.yesterday.to_s(:extended)
    arlo.download(record: video, time_frame: time_frame)

    puts "Succesfully download video #{video.name}"
    puts '################'
    2.times { puts '' }
  end

  puts "Done for the day, phewww!!!"
end
