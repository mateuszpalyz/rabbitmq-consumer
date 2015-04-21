class Publisher

  def self.publish(acknowledgement)
    x = channel.direct('currencies.direct', routing_key: 'acknowledgements')
    x.publish(acknowledgement.to_json)
  end

  private

  def self.channel
    @channel ||= connection.create_channel
  end

  def self.connection
    @connection ||= Bunny.new.tap { |c| c.start }
  end
end
