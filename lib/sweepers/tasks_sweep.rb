module Sweepers
  class TasksSweep

    def initialize(keep_duration)

      @keep_duration = keep_duration
    end


    def call

      puts "Cleaning logs from tasks table..."


      table_name = self.class.name.demodulize.gsub('Sweep', '').tableize


      query = "DELETE FROM #{table_name} WHERE created_at < '#{@keep_duration.strftime("%Y-%m-%d %H:%M:%S")}'"

      puts "Executing query: #{query}"

      logs = ActiveRecord::Base.connection.execute(query)

      puts "Logs deleted from tasks table."
    end
  end
end
