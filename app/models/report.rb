class Report

  def initialize(from, to, type, message)
    @from = from
    @to = to
    @type = type
    @message = message
  end

  def save
    REDIS.lpush("reports", self.to_json)
  end

  def as_json(opts={})
    {:from => @from, :to => @to, :type => @type, :message => @message}
  end

end
