module Polygon
  module Script
    class Open < Polygon::Script(__FILE__, __LINE__)

      attr_accessor :mode, :refresh_repo, :sync_repo, :bundle, :open_browser, :try, :max

      def config_ru
        root/:config/"#{mode}.ru"
      end
  
      # Install the options
      options do |opt|
        self.enable_logging = true
        opt.on('--[no-]log', "Properly log in a file?") do |value|
          self.enable_logging = value
        end
        self.refresh_repo = true
        opt.on('--[no-]refresh', "Issues a 'git remote update' first?") do |value|
          self.refresh_repo = value
        end
        self.sync_repo = true
        opt.on('--[no-]sync', "Issues a 'git rebase origin/master' first?") do |value|
          self.refresh_repo = value
        end
        self.bundle = true
        opt.on('--[no-]bundle', "Issues a 'bundle' first?") do |value|
          self.bundle = value
        end
        self.open_browser = true
        opt.on('--[no-]browser', "Open the browser automatically?") do |value|
          self.open_browser = value
        end
        self.try = 0
        self.max = 500
        opt.on('--max=MAX', Integer, "Number of connection attempts") do |value|
          self.max = Integer(value)
        end
      end
  
      # Tries to access the website
      def wait_and_open
        info "Attempting to connect to the web site..."
        Http.head "http://127.0.0.1:3000/"
      rescue Errno::ECONNREFUSED
        sleep(0.5)
        retry if (self.try += 1) < max
        info "Server not found, sorry."
        raise
      else
        Launchy.open("http://127.0.0.1:3000/")
      end
  
      def execute(argv)
        abort options.to_s unless argv.size <= 1
        self.mode = (argv.first || "development").to_sym
        abort "Invalid mode #{mode}" unless config_ru.exist?

        info "Refreshing repository info..." do
          Process.wait spawn("git remote update")
          Process.wait spawn("git fetch origin")
        end if refresh_repo

        info "Syncing repository..." do
          Process.wait spawn("git pull origin master")
        end if sync_repo

        info "Bundling..." do
          Process.wait spawn("bundle")
        end if bundle

        thinpid = nil
        info "Starting the web server..." do
          thinpid = spawn("thin -R #{config_ru} start")
        end

        info "Waiting for the server to start" do
          require 'launchy'
          require 'http'
          wait_and_open
        end if open_browser

      rescue => ex
        info "Lauching failed: #{ex.message}"
        info ex.backtrace.join("\n")
        Process.kill("SIGHUP", thinpid) if thinpid
      ensure
        Process.wait(thinpid) if thinpid
        flush_logs
      end

    end # class Open
    Launch = Open
  end # module Script
end # module Polygon
