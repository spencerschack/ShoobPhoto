module ActionDispatch
  module Http
    module URL
      def request_uri
        path
      end
    end
  end
end