class CurrencyWorker
  include Sneakers::Worker
  from_queue "currencies.queue_#{ENV['QUEUE_ID']}", env: nil

  def work(message)
    message = JSON.parse(message)
    create_currency_from_message(message)
    Publisher.publish(acknowledgement(message))
    ack!
  end

  private

  def create_currency_from_message(message)
    Currency.create(message.slice(:uuid, :rates))
  end

  def acknowledgement(message)
    message.merge(id: ENV['QUEUE_ID']).except(:rates)
  end
end
