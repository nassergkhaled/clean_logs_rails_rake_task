desc "File Manager"

task :create_file do
  file_name = "new_file.txt"
  File.write(new_file, "This is a new file.")
  puts "File created!"
end

  task :remove_file do
    file_to_remove = "new_file.txt"
    FileUtils.rm(file_to_remove)
    puts "File removed!"
  end

    task :update_file do
    file_to_update = "new_file.txt"
    File.write(new_file , "This is update file")
    puts "File updated successfully"
    end
