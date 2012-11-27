class Powerup < Chingu::GameObject
	has_traits :collision_detection, :bounding_box, :velocity
	attr_reader :power
	def setup
		@velocity_y = 5
		x = rand(1..2)
		@image = Gosu::Image["./lib/powerups/upgrade#{x}.png"]
		@power = x
	end

	def update
		if @x > @@windowX then self.destroy end

	end
end


class Cannon1
	def setup
	end
end

class Cannon2
end