class Menu_item1 < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["start_button.png"]
		@x = $window.width/2 - 50
		@y = $window.height/2 - 50
	end
end

class Menu_item2 < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["exit_button.png"]
		@x = 400 - 50
		@y = 400
	end
end

