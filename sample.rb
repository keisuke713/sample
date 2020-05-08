module Scheduable
  attr_writer :schedule
  def schedule
    @schedule ||= ::Schedule.new
  end

  def schedulable?(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end

  def lead_days
    0
  end
end

class Schedule
  def scheduled?(schedulable, start_date, end_date)
  end
end

class Bicycle
  attr_reader :schedule, :size, :chain, :tire_size
  def initialize(args={})
    @schedule  = args[:schedule]
    @size      = args[:size]
    @chain     = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  def lead_days
    1
  end

  def post_initialize(args)
    nil
  end

  def default_chain
    "10-speed"
  end

  def default_tire_size
    raise NotImplementedError
          "This #{self.class} cannot respond to:"
  end  
 
  def spares
    { tire_size: tire_size,
      chain: chain}.merge(local_spares)
  end

  def local_spares
    nil
  end
end

class RoadBike < Bicycle 
  attr_reader :tape_color
  def post_initialize(args)
    @tape_color = args[:tape_color]
    super(args)
  end
 
  def local_spares
    {tape_color: tape_color}
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock
  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock  = args[:rear_shock]
    super(args)
  end

  def local_spares
    {rear_shock: rear_shock}
  end

  def default_tire_size
    '2.1'
  end
end

