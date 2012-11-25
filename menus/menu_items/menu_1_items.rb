class Menu_start < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["./buttons/start_button.png"]
		@x = $window.width/2 - 50
		@y = $window.height/2 - 50
	end
end


class Menu_chars < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["./buttons/characters_button.png"]
		@x = $window.width/2 - 60
		@y = 400
	end
end

