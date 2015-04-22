class CurrencyWorker
  include Sneakers::Worker
  from_queue "currencies.queue_#{ENV['QUEUE_ID']}", env: nil

  def work(message)
    message = JSON.parse(message)
    currency = Currency.new(message.slice('uuid', 'rates'))

    if currency.save
      Publisher.publish(acknowledgement(message))
      ack!
    else
      reject!
    end
  end

  private

  def acknowledgement(message)
    message.merge(id: ENV['QUEUE_ID']).except(:rates)
  end
end
