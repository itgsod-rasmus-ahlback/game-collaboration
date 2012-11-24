class Cursor < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["cursor.png"]
		@zorder = 300
	end

	def update
		@x = $window.mouse_x
		@y = $window.mouse_y
	end
end