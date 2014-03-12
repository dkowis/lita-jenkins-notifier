module Lita
    module Handlers
        class JenkinsNotifier < Handler

            def self.default_config(config)
                config.jobs = {}
            end

            http.post "/jenkins/notifications", :build_notification

            def build_notification(request, response)
                json_stuff = request.params['payload']
                begin
                    payload = MultiJson.load(json_stuff)
                rescue MultiJson::LoadError => e
                    Lita.logger.error("Could not parse JSON payload from jenkins: #{e.message}")
                    Lita.logger.debug("JSON PAYLOAD: " + json_stuff)
                    return
                end
                rooms = get_rooms(payload['name'])

                message = create_message(payload)
                rooms.each do |room|
                    target = Source.new(room: room)
                    robot.send_message(target, message)
                end
            end

            private

            def create_message(payload)
                require 'pp'
                pp payload
                if payload['build']['phase'] == "STARTED"
                    "[Jenkins] Build ##{payload['build']['number']} started for job #{payload['name']}..."
                end
            end

            def get_rooms(job_name)
                jobs = Lita.config.handlers.jenkins_notifier.jobs

                rooms = []
                jobs.keys.each do |key|
                    if key.match(job_name)
                        rooms << jobs[key]
                    end
                end

                if rooms.empty?
                    Lita.logger.warn "Jenkins notification for job that didn't match any: #{job_name}"
                end

                rooms.sort.uniq
            end
        end

        Lita.register_handler(JenkinsNotifier)
    end
end
