# Citrix

[![Build Status](https://travis-ci.org/fnando/citrix.svg)](https://travis-ci.org/fnando/citrix)
[![Code Climate](https://codeclimate.com/github/fnando/citrix/badges/gpa.svg)](https://codeclimate.com/github/fnando/citrix)
[![Test Coverage](https://codeclimate.com/github/fnando/citrix/badges/coverage.svg)](https://codeclimate.com/github/fnando/citrix)

API wrappers for Citrix services like GoToTraining. It includes partial API mapping for GoToTraining.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'citrix'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install citrix

## Usage

### GoToTraining

#### Create client

Initialize a client with provided credentials.
The credentials must be a instance of or
a Hash accepted by `Citrix::Training::Credentials`.

```ruby
client = Citrix::Training::Client.build(
  oauth_token: ENV.fetch('CITRIX_OAUTH_TOKEN'),
  organizer_key: ENV.fetch('CITRIX_ORGANIZER_KEY'),
  account_key: ENV.fetch('CITRIX_ACCOUNT_KEY')
)
```

#### Create training

```ruby
response, training = client.trainings.create({
  name: 'Ruby on Rails',
  description: 'Getting started with Ruby on Rails',
  timezone: 'America/Sao_Paulo',
  dates: [date],
  web_registration: false,
  confirmation_email: false,
  organizers: [organizer]
})

if response.ok?
  # Training successfully created!
else
  p response.json
end
```

#### Get all trainings

Retrieve information on all scheduled trainings for a given organizer.

```ruby
response, trainings = client.trainings.all

if trainings
  # Retrieved all trainings
else
  p response.json
end
```

#### Remove a training

Deletes a scheduled or completed training.

```ruby
response = client.trainings.remove(training)
response.ok? #=> successfully removed
```

#### Add registrant

Register one person, identified by a unique email address, for a training.

```ruby
response, registrant = client.registrants(training).create({
  first_name: 'John',
  last_name: 'Doe',
  email: 'john@example.com'
})

if response.ok?
  # Do something with registrant
else
  p response.json
end
```

#### Get all registrants

Retrieve details on all registrants for a specific training.

```ruby
response, registrants = client.registrants(training).all

if response.ok?
  # Do something with registrants
else
  p response.json
end
```

#### Remove registrant

This call cancels a registration in a scheduled training for a
specific registrant.

```ruby
response = client.registrants(training).remove(registrant)
response.ok? #=> successfully removed
```

## Contributing

1. Fork it ( https://github.com/fnando/citrix/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
