module FolderHelper
  def find_or_create_folder(time_frame:)
    name = Rails.root.join('public', 'videos', time_frame)
    Dir.mkdir(name) unless directory_exists?(name)
    name
  end

  def directory_exists?(directory)
    File.directory?(directory)
  end
end