class Menu_exit < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["./buttons/exit_button.png"]
		@x = 700
		@y = 50
		@cursor = Cursor.create
	end

	def check
		self.each_collision(@cursor) do
			@cursor.destroy
			exit
		end
	end
end

class Menu_back < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection
	has_traits :timer
	def setup
		@image = Gosu::Image["./buttons/back_button.png"]
		@x = 100
		@y = 100
		@cursor = Cursor.create
	end

	def check
		self.each_collision(@cursor) do
			@cursor.destroy
			$window.switch_game_state(MainMenu)
		end
		puts "this is the back class"
	end
end