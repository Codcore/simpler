module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @params = {}
      end

      def match?(method, path)
        @method == method && check_request_path(path)
      end

      private

      def check_request_path(path)
        params_regexp = Regexp.new(/:[a-zA-Z]*/i)

        request_path_array = path.split('/').reject!(&:empty?)
        router_path_array  = @path.split('/').reject!(&:empty?)

        return false unless router_path_array.size == request_path_array.size

        router_path_array.each_with_index do |part, i|
          if part.match?(params_regexp)
            @params[router_path_array[i]] = request_path_array[i]
          else
            return false unless part == request_path_array[i]
          end
        end

        true
      end
    end
  end
end
