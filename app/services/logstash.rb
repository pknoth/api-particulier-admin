class Logstash
  include Elasticsearch::DSL

  attr_reader :client

  def initialize
    @client = Elasticsearch::Client.new
  end

  def count_by_name(name)
    definition = search do
      size 100
      query { match 'consumer.organisation' => name }
    end
    res = client.search(
      index: 'logstash-api-particulier-*',
      body: definition.to_hash,
      sort: [{ '@timestamp' => { order: 'desc' } }],
      size: 100
    )
    res['hits']['total']
  end
end
