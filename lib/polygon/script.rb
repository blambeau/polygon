require 'polygon'
require 'quickl'
require 'logger'
module Polygon
  module Script

    attr_accessor :enable_logging

    def root
      Path($0).backfind('.[config.ru]') || Path.pwd.backfind('.[config.ru]')
    end

    def logger
      @logger ||= Logger.new(root/:logs/"#{Quickl.command_name(self)}.log") if enable_logging
    end

    def log(message, severity)
      puts message
      logger.send(severity, message) if enable_logging
      yield if block_given?
    end
    def debug(message, &block); log(message, :debug, &block); end
    def info(message, &block);  log(message, :info,  &block); end
    def warn(message, &block);  log(message, :warn,  &block); end
    def error(message, &block); log(message, :error, &block); end
    def fatal(message, &block); log(message, :fatal, &block); end

  end

  def self.Script(*args)
    Quickl::Command(*args) do |builder|
      builder.instance_module Script
    end
  end

end
require 'polygon/script/launch'