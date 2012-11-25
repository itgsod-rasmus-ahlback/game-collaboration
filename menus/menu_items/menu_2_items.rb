class Menu_load < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["./buttons/load_button.png"]
		@x = 350
		@y = 200
	end
end

class Menu_new < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["./buttons/new_char_button.png"]
		@x = 350
		@y = 300
	end
end