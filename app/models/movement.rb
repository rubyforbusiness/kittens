class Movement < Direction
  enum direction: [:forward]
  def initialize(*params)
    defaults = { distance: 1}
    params[0] = defaults.merge(params[0] || {} )
    super(*params)
  end
end
