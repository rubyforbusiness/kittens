# Specifies position in terms of coordinates
class Location
  attr_accessor :x, :y, :facing

  FACING_TRANSITIONS = {
    north: {
      left: :west,
      right: :east
    },
    west: {
      left: :south,
      right: :north
    },
    east: {
      left: :north,
      right: :south
    },
    south: {
      left: :east,
      right: :west
    },
  }

  MOVEMENT_DELTAS = {
    forward: {
      north: [0,1],
      west: [-1,0],
      east: [1,0],
      south: [0,-1],
    }
  }

  def initialize
    @x = 0
    @y = 0
    @facing = :north
  end

  def update(direction)
    case direction&.type
    when "Turn"
      update_facing direction.instruction.to_sym
    when "Movement"
      update_position direction
    else
      raise "invalid type for direction: #{direction&.type}"
    end
  end

  def position
    [self.x, self.y]
  end

  def position=(coords)
    @x = coords.first
    @y = coords.last
  end

  private

  def update_facing(instruction)
    self.facing = FACING_TRANSITIONS[self.facing][instruction]
  end

  def update_position(direction)
    (1..direction.distance).each do
      self.position = [self.x, self.y].map.with_index do |pos, index|
        pos + MOVEMENT_DELTAS
                .fetch(direction&.direction&.to_sym)
                &.fetch(self.facing)
                &.at(index)
      end
    end
  end
end