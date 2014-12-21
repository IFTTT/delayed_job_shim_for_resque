# DelayedJobShimForResque

Shims Delayed Job's delay and handle_asynchronously methods into Resque

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'delayed_job_shim_for_resque'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install delayed_job_shim_for_resque

## Usage

At this point, this should be used with caution. It monkey-patches over Delayed Job so that you can migrate to Resque.

## Contributing

1. Fork it ( https://github.com/IFTTT/delayed_job_shim_for_resque/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
