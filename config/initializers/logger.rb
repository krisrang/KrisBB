if Rails.env.production?
  class Formatter
    SEVERITY_TO_COLOR_MAP = 
      { 'DEBUG'=>'0;37', 
        'INFO'=>'32', 
        'WARN'=>'33', 
        'ERROR'=>'31', 
        'FATAL'=>'31', 
        'UNKNOWN'=>'37'}

    def call(severity, time, progname, msg)
      formatted_severity = sprintf("%-5s","#{severity}")

      formatted_time = 
        time.strftime("%Y-%m-%d %H:%M:%S.") << time.usec.to_s[0..2].rjust(3)

      color = SEVERITY_TO_COLOR_MAP[severity]

      "\033[0;37m#{formatted_time}\033[0m [\033[#{color}m#{formatted_severity}\033[0m] #{msg.strip} (pid:#{$$})\n"
    end

  end

  begin
    STDOUT.sync = true

    def Rails.stdout_logger
      logger = Logger.new(STDOUT)
      logger.level = Logger.const_get(([ENV['LOG_LEVEL'].to_s.upcase, "INFO"] & %w[DEBUG INFO WARN ERROR FATAL UNKNOWN]).compact.first)
      logger.formatter = Formatter.new
      logger
    end

     Rails.logger = Rails.application.config.logger = Rails.stdout_logger
  rescue Exception => ex
    puts "WARNING: Exception during rails_log_stdout init: #{ex.message}"
  end
end
