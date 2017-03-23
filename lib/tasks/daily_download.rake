desc 'Daily download all videos from Arlo account'

def ask_for_date
  input = ENV['OPTION'] || nil

  while !input.in? %w(1 2)
    puts 'Please choose date:'
    puts '1. Yesterday (default)'
    puts '2. Custom date'
    input = STDIN.gets.chomp
  end

  if input == '1'
    puts 'Logged in! Getting yesterday videos.'
    from_date = to_date = DateTime.now.yesterday.to_s(:basic)
  elsif input == '2'
    puts 'From which date? (format YYYYMMDD - Ex: 20170130)'
    from_date = STDIN.gets.chomp
    puts 'To which date? (format YYYYMMDD - Ex: 20170131)'
    to_date = STDIN.gets.chomp
  end
  [from_date, to_date]
end

task :download_yesterday_videos => :environment do
  puts "Initializing"

  arlo = Arlo.new
  from_date, to_date = ask_for_date
  video_list = arlo.get_library(from_date: from_date, to_date: to_date)
  counts = video_list.size

  puts "There are #{counts} videos in this period"

  video_list.each_with_index do |video, index|
    puts "#{index + 1}/#{counts} Downloading video: #{video.name}"

    arlo.download(record: video)

    puts "Succesfully download video #{video.name}"
    puts '################'
    2.times { puts '' }
  end

  puts "Done for the day, phewww!!!"
end
