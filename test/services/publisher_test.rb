require 'test_helper'

class PublisherTest < ActiveSupport::TestCase

  test 'publisher returs bunny exchange' do
    assert_kind_of Bunny::Exchange, Publisher.publish({})
  end
end
