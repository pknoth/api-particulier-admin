class Logstash
  include Elasticsearch::DSL

  attr_reader :client

  def initialize
    @client = Elasticsearch::Client.new
  end

  def count_by_name(name)
    definition = search do
      query { match 'consumer.organisation' => name }
    end
    res = client.count(
      index: 'logstash-api-particulier-*',
      body: definition.to_hash,
    )
    res['count']
  end
end
