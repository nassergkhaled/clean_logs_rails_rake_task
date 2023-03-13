# module Sweeper
#   class Log
#     KeepDuration = 3.months
#
#
#     def call
#       execute "delete"
#     end
#   end
# end

# file: sweepers/example_sweeper.rb


# class Tasks < SweeperBase
#   KeepDuration = 30 #days
#
#   def initialize()
#   end
#
#   def call
#     puts "I am in"
#     query = "DELETE FROM tasks WHERE created_at < '#{KeepDuration.days.ago.to_date}'"
#     puts "Executing query: #{query}"
#     logs = ActiveRecord::Base.connection.execute(query)
#     puts "logs deleted from tasks table"
#   end
# end

# require_relative '../tasks/sweeper_base'
module Sweepers
  class TaskSweep
    def initialize(keep_duration)
      @keep_duration = keep_duration
    end

    def call
      puts "Cleaning logs from tasks table..."
      query = "DELETE FROM tasks WHERE created_at < '#{@keep_duration.strftime("%Y-%m-%d %H:%M:%S")}'"
      puts "Executing query: #{query}"
      logs = ActiveRecord::Base.connection.execute(query)
      puts "Logs deleted from tasks table."
    end
  end
end
