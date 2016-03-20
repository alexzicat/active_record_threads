require 'active_record_threads/version'

module ActiveRecordThreads
  class << self
    def execute(&block)
      Thread.new do
        begin
          ActiveRecord::Base.connection_pool.with_connection { block.call }
        rescue Exception => e
          raise e
        ensure
          ActiveRecord::Base.connection.close if ActiveRecord::Base.connection
        end
      end
    end
  end
end
