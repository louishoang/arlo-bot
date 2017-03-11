desc 'Daily download all videos from Arlo account'

task :daily_download => :environment do
  puts "Initializing"
  arlo = Arlo.new

  puts 'Logged in, start getting library'
  video_list = arlo.get_library

  puts "There are #{video_list.size} videos in this period"

  video_list.each do |video|
    puts "Downloading video: #{video.name}"

    arlo.download(video)

    puts "Succesfully download video #{video.name}"
    puts '################'
    2.times { puts '' }
  end

  puts "Done for the day, phewww!!!"
end