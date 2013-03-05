require 'polygon'
require 'quickl'
require 'logger'
module Polygon
  module Script

    attr_accessor :enable_logging

    def root
      Path($0).backfind('.[config.ru]') || Path.pwd.backfind('.[config.ru]')
    end

    def log_io
      @log_io ||= File.open(root/:logs/"#{Quickl.command_name(self)}.log".to_s, "w")
    end

    def log(message, severity)
      puts message
      log_io.puts("#{severity}: #{message}") if enable_logging
      log_io.flush
      yield if block_given?
    end
    def debug(message, &block); log(message, :debug, &block); end
    def info(message, &block);  log(message, :info,  &block); end
    def warn(message, &block);  log(message, :warn,  &block); end
    def error(message, &block); log(message, :error, &block); end
    def fatal(message, &block); log(message, :fatal, &block); end

    def flush_logs
      @log_io.close if @log_io
    end

    def spawn(command)
      if enable_logging
        Kernel.spawn(command, [:out, :err] => log_io)
      else
        Kernel.spawn(command)
      end
    end

  end

  def self.Script(*args)
    Quickl::Command(*args) do |builder|
      builder.instance_module Script
    end
  end

end
require 'polygon/script/launch'
require 'polygon/script/gsub'