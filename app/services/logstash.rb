class Logstash
  include Elasticsearch::DSL

  attr_reader :client

  def initialize
    @client = Elasticsearch::Client.new
  end

end
