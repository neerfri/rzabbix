require 'rzabbix'

RZabbix::Connection.set_credentials("host", "user", "pass")

RSpec.configure do |config|
  # == Mock Framework
  #
  # RSpec uses its own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :rspec
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
end