require_relative 'view'

module Simpler
  class Controller

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action
      @request.env['simpler.params'] = params

      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    def params
      @request.params
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      unless @response.body.any?
        body = render_body
        @response.write(body)
      end
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def render(template)

      if template.is_a?(Hash)
        case template.keys.first
        when :plain
          @response['Content-Type'] = 'text/plain'
          @response.write(template[:plain])
          @response.finish
        end
      else
        @request.env['simpler.template'] = template
      end
    end

    def status(code)
      @response.status = code
    end

    def headers
      @response
    end
  end
end
