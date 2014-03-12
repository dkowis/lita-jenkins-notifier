# lita-jenkins-notifier

[![Build Status](https://travis-ci.org/dkowis/lita-jenkins-notifier.png)](https://travis-ci.org/dkowis/lita-jenkins-notifier)
[![Code Climate](https://codeclimate.com/github/dkowis/lita-jenkins-notifier.png)](https://codeclimate.com/github/dkowis/lita-jenkins-notifier)
[![Coverage Status](https://coveralls.io/repos/dkowis/lita-jenkins-notifier/badge.png)](https://coveralls.io/r/dkowis/lita-jenkins-notifier)


This plugin will provide a way for the [Jenkins Notification Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Notification+Plugin)
to push notifications to your bot, so it can annoy you in IRC when things fail, or succeed, or some combination of both!

## Installation

Add lita-jenkins-notifier to your Lita instance's Gemfile:

``` ruby
gem "lita-jenkins-notifier"
```

## Configuration

`jobs` (Hash) - A map of job names to channel notifications.
Keys should be a regex that matches a job name (Dev.*) . You could match many of the regexpes, all will be tested.
Values should be either the string room name, or an array of string room names.

### Example

```ruby
Lita.configure do |config|
  config.handlers.jenkins_notifier.jbos = {
    "JenkinsJob" => "#someroom",
    ".*" => "#spamroom"
  }
```

## Usage

You add to the jenkins notifier plugin to post to the `http://<BotHost>:<port>/jenkins/notifications` and when builds happen
it'll notify in chat based on the matched job name.

## License

[MIT](http://opensource.org/licenses/MIT)
