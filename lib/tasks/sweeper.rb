Dir.glob("#{File.dirname(__FILE__)}/../../lib/sweepers/*.rb").each do |file|
  require file
end


class Sweeper
  SWEEPERS_DIR = File.join(Rails.root, 'lib', 'sweepers')

  SWEEPERS = Dir.glob("#{SWEEPERS_DIR}/*_sweep.rb").map do |file_path|
    File.basename(file_path, '.rb').camelize
  end.freeze

  def self.clean_all_tables
    ActiveRecord::Base.establish_connection

    if SWEEPERS.empty?
      puts "No sweep files found in #{SWEEPERS_DIR}"
    else

      SWEEPERS.each do |sweeper_name|

        sweeper_class_name = "Sweepers::#{sweeper_name}"

        sweeper_class = Object.const_get(sweeper_class_name) rescue nil
        if sweeper_class.nil?
          puts "Unable to find class #{sweeper_class_name}"
        else

          puts "Cleaning logs for #{sweeper_class_name}"
          sweeper_class.new(10.days.ago).call
        end
      end
    end
  end
end
