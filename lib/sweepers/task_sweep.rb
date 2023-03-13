module Sweepers
  class TaskSweep
    # Define the constructor for TaskSweep, which takes a keep_duration argument
    def initialize(keep_duration)
      # Assign the keep_duration argument to an instance variable
      @keep_duration = keep_duration
    end

    # Define the call method for TaskSweep
    def call
      # Print a message indicating that the logs from the tasks table are being cleaned
      puts "Cleaning logs from tasks table..."

      # Define a SQL query to delete rows from the tasks table where the created_at date is earlier than the keep_duration date
      query = "DELETE FROM tasks WHERE created_at < '#{@keep_duration.strftime("%Y-%m-%d %H:%M:%S")}'"

      # Print a message indicating that the query is being executed
      puts "Executing query: #{query}"

      # Execute the query and assign the result to a logs variable
      logs = ActiveRecord::Base.connection.execute(query)

      # Print a message indicating that the logs have been deleted from the tasks table
      puts "Logs deleted from tasks table."
    end
  end
end
