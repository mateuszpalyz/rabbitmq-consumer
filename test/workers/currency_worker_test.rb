require 'test_helper'

class CurrencyWorkerTest < ActiveSupport::TestCase

  def setup
    @worker = CurrencyWorker.new
    @message = { uuid: 'asdasd', rates: [ aud: 1.23, pln: 3.81] }.to_json
  end

  test 'should create currency object from message' do
    assert_difference 'Currency.count', 1 do
      @worker.work(@message)
    end
  end

  test 'should return ack' do
    assert_equal :ack, @worker.work(@message)
  end

  test 'should call publisher to publish ack' do
    Publisher.expects(:publish)
    @worker.work(@message)
  end
end
