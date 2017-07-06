class Logstash
  include Elasticsearch::DSL

  attr_reader :client

  def initialize
    @client = Elasticsearch::Client.new
  end

  def last_100_by_name(name)
    definition = search do
      size 100
      query { match 'consumer.name' => name }
    end
    client.search(
      index: 'logstash-api-particulier-*',
      body: definition.to_hash
    ).to_a
  end
end
