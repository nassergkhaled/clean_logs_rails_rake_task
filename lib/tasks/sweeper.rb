require_relative '../../lib/sweepers/task_sweep'

class Sweeper
  # Define the SWEEPERS_DIR constant as the path to the sweepers directory
  SWEEPERS_DIR = File.join(Rails.root, 'lib', 'sweepers')

  # Set the SWEEPERS constant to an array of sweepers, based on the files in the sweepers directory
  SWEEPERS = Dir.glob("#{SWEEPERS_DIR}/*_sweep.rb").map do |file_path|
    # Convert the file name to a camel-case class name and add it to the array
    File.basename(file_path, '.rb').camelize
  end.freeze # freeze the array to prevent modifications

  # Define the clean_all_tables class method
  def self.clean_all_tables
    # Establish a connection to the database
    ActiveRecord::Base.establish_connection

    # If there are no sweepers found in the SWEEPERS array, print a message
    if SWEEPERS.empty?
      puts "No sweep files found in #{SWEEPERS_DIR}"
    else
      # For each sweeper in the SWEEPERS array
      SWEEPERS.each do |sweeper_name|
        # Derive the class name of the sweeper by appending the Sweepers namespace to the camel-case class name
        sweeper_class_name = "Sweepers::#{sweeper_name}"

        # Use Object.const_get to get the class object of the sweeper
        # If the class is not found, print a message
        sweeper_class = Object.const_get(sweeper_class_name) rescue nil
        if sweeper_class.nil?
          puts "Unable to find class #{sweeper_class_name}"
        else
          # If the sweeper class is found, print a message saying that the logs for the sweeper are being cleaned
          # Instantiate the sweeper with an argument of 10 days ago and call its call method
          puts "Cleaning logs for #{sweeper_class_name}"
          sweeper_class.new(10.days.ago).call
        end
      end
    end
  end
end
