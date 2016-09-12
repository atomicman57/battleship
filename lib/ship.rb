class Ship
  attr_accessor :type, :char, :length, :x, :y, :orientation, :points

  def initialize (options)
    self.type = options[:type]
    self.char = options[:type][0].upcase
    self.length = options[:length]
    self.x = options[:x]
    self.y = options[:y]
    self.orientation = options[:orientation]
    initialize_ship_points
  end

  def initialize_ship_points
    # a hash of ship points, with keys = an array of coordinates
    # and values = state of that point ('.' or '#')
    self.points = {}
    if orientation == 0 # vertical
      length.times do |n|
        points[[x, y+n]] = "."
      end
    else # horizontal
      length.times do |n|
        points[[x+n, y]] = "."
      end
    end
  end
end

