module FolderHelper
  def find_or_create_folder(time_frame: nil)
    directory_name = time_frame || DateTime.now.to_s(:extended)
    name = Rails.root.join('public', 'videos', directory_name)
    Dir.mkdir(name) unless directory_exists?(name)
    name
  end

  def directory_exists?(directory)
    File.directory?(directory)
  end
end