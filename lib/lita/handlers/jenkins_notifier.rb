module Lita
  module Handlers
    class JenkinsNotifier < Handler
    end

    Lita.register_handler(JenkinsNotifier)
  end
end
