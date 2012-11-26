class Menu_start < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["./buttons/start_button.png"]
		if @x == 0
			@x = $window.width/2 - 50
			@y = $window.height/2 - 50
		end
		@cursor = Cursor.create
	end

	def check
		self.each_collision(@cursor) do
			@cursor.destroy
			$window.switch_game_state(StartGame)
		end
	end
end


class Menu_chars < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["./buttons/characters_button.png"]
		if @x == 0
			@x = $window.width/2 - 60
			@y = 400
		end
		@cursor = Cursor.create
	end

	def check
		self.each_collision(@cursor) do
			@cursor.destroy
			$window.switch_game_state(List_characters)
		end
	end
end

