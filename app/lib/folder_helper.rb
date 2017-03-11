module FolderHelper
  def find_or_create_today_folder
    name = Rails.root.join('public', 'videos', DateTime.now.to_s(:extended))
    Dir.mkdir(name) unless directory_exists?(name)
    name
  end

  def directory_exists?(directory)
    File.directory?(directory)
  end
end