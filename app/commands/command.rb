class Command
  def self.perform
    raise NotImplementedError.new("You must implement 'perform' method.")
  end

  def self.for(params)
    self.perform(params)
  end
end
