class Menu_item1 < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		puts "hej"
		@image = Gosu::Image["cloud.png"]
		@x = 100
		@y = 100
	end
end

