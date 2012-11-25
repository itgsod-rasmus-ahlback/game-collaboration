class Menu_exit < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["./buttons/exit_button.png"]
		@x = 700
		@y = 50
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
	end
end