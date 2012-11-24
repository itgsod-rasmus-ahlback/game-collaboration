class Menu2_back < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection
	has_traits :timer
	def setup
		@image = Gosu::Image["back_button.png"]
		@x = 100
		@y = 100
	end
end