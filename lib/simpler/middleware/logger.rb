require 'logger'

module Simpler
  class AppLogger
    def initialize(app)
      @logger = Logger.new(File.expand_path('../log/app.log', __dir__))
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      @logger.info(log(env, status, headers))
      [status, headers, body]
    end

    private

    def log(env, status, headers)
      "\n" +
      "Request: #{env['REQUEST_METHOD']} #{env['REQUEST_URI']}\n" +
      "Handler: #{env['simpler.controller'].class}##{env['simpler.action']}\n" +
      "Parameters: #{env['simpler.params']}\n" +
      "Response: #{status} [#{headers['Content-Type']}] #{env['simpler.template_path']}\n"
    end
  end
end