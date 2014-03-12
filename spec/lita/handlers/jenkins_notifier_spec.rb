require "spec_helper"

describe Lita::Handlers::JenkinsNotifier, lita_handler: true do

    it { routes_http(:post, "/jenkins/notifications").to(:build_notification) }

    describe "#build_notification" do
        let(:request) do
            request = double("Rack::Request")
            allow(request).to receive(:params).and_return(params)
            request
        end

        let(:response) { Rack::Response.new }

        let(:params) { double("Hash") }

        # phase: STARTED, COMPLETED, FINISHED
        # status: ABORTED, FAILURE, NOT_BUILT, SUCCESS, UNSTABLE
        def jenkins_payload(job_name, build_number, phase, status, branch)
            <<-DATA.chomp
{"name":"#{job_name}",
 "url":"JobUrl",
 "build":{"number":#{build_number},
	  "phase":"#{phase}",
	  "status":"#{status}",
          "url":"job/project/5",
          "full_url":"http://ci.jenkins.org/job/project/5",
          "parameters":{"branch":"#{branch}"}
	 }
}
            DATA
        end

        context "notifications from jenkins" do
            it "sends a notification when the build starts" do
                Lita.config.handlers.jenkins_notifier.jobs[/.*/] = "#baz"
                expect(robot).to receive(:send_message) do |target, message|
                    expect(target.room).to eq("#baz")
                    expect(message).to include("[Jenkins] Job job #1 STARTED on branch master")
                end

                allow(params).to receive(:[]).with("payload").and_return(jenkins_payload("job", 1, "STARTED", "SUCCESS", "master"))

                subject.build_notification(request, response)
            end
            it "sends a notification message when the build fails"
            it "sends a notification message when the build passes"
            it "sends a notification message when the build is still passing"
            it "sends a notification message when the build is still failing"
        end


    end
end
