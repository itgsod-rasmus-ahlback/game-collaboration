class Menu_load < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["moggeslogo.png"]
		@x = 300
		@y = 300
		@cursor = Cursor.create
	end

	def check
		self.each_collision(@cursor) do
		@cursor.destroy
		$window.switch_game_state(MorganGame)
		end
	end
end

class Menu_new < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["./thumbnails/goc.png"]
		@x = 100
		@y = 300
		@cursor = Cursor.create
	end

	def check
		self.each_collision(@cursor) do
			@cursor.destroy
			$window.switch_game_state(Gameplay)
		end
	end
end

class Menu_lund < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["./asteroid.png"]
		@x = 200
		@y = 300
		self.zorder = 10
		@cursor = Cursor.create
	end

	def check
		self.each_collision(@cursor) do
			@cursor.destroy
			$window.switch_game_state(Lund)
		end
	end
end

