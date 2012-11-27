class Gameplay < Chingu::GameState
	# Constructor
	def initialize
		super
		self.input = {esc: :next}
		@background_image = Background.create
		@player = Player.create
		@cloud = Cloud.create
	end

	def needs_cursor?
    	false
  	end

  	def next
  		switch_game_state(StartGame)
  	end

  	def update
  		super
  		Laser.each_collision(Cloud) do |laser, cloud|
  			laser.destroy
  			cloud.destroy
  		end
  	end

end

class Player < Chingu::GameObject
	has_traits :velocity, :timer

	# meta/constructor
	def setup
		@x, @y = 350, 400
		@image = Gosu::Image["./final_ship.png"]
		self.input = {
			holding_left: :left,
			holding_right: :right,
			holding_up: :up,
			holding_down: :down,
			holding_space: :fire,
			holding_mouse_right: :make
			}
		@speed = 10
		@angle = 0
		@counter = 0
		self.zorder = 2
	end



	def fire
		Laser.create(x: self.x, y: self.y, angle: self.angle)
	end

	def left
		@angle -= 4.5
	end

	def right
		@angle += 4.5
	end

	def up
		self.velocity_y += Gosu::offset_y(@angle, 0.5)
		self.velocity_x += Gosu::offset_x(@angle, 0.5)
	end

	def down
		self.velocity_x -= Gosu::offset_x(@angle, 0.5)
		self.velocity_y -= Gosu::offset_y(@angle, 0.5)
	end

	def update
		self.velocity_x *= 0.95
		self.velocity_y *= 0.95
		@x %= 800
		@y %= 600

		$window.caption = ("Game Of Clouds: FPS #{$window.fps}")

		if @counter == 90
			Cloud.create
			@counter = 0
		end

		@counter += 1
	end

	def make 
		Laser.create(x: $window.mouse_x, y: $window.mouse_y, angle: self.angle)
	end


end


class Background < Chingu::GameObject
	
	def setup
		@x = 800/2
		@y = 600/2
		@image = Gosu::Image["ocean.png"]
		self.zorder = 0
	end
end

class Laser < Chingu::GameObject
	has_traits :velocity, :timer, :bounding_circle
	traits :collision_detection
	def setup
		self.collidable = true
		@image = Gosu::Image["shoot.png"]
		self.velocity_y = Gosu::offset_y(@angle, 20)
		self.velocity_x = Gosu::offset_x(@angle, 20)
		after(1000) {self.destroy}
		self.zorder = 1
	end
end

class Cloud < Chingu::GameObject
	has_traits :velocity, :bounding_circle
	traits :collision_detection

	def setup
		self.collidable = true
		@image = Gosu::Image["cloud.png"]
		@y = -50
		@angle = 180
		@x = rand(1..800)
		self.velocity_y = Gosu::offset_y(@angle, 1)
		self.zorder = 3
	end

	def update
		if @y > 650 
			die
		end
	end

	def die
		self.destroy
	end

end
