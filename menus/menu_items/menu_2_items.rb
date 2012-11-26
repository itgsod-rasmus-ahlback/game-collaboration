class Menu_load < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["./buttons/load_button.png"]
		@x = 350
		@y = 200
		@cursor = Cursor.create
	end

	def check
		self.each_collision(@cursor) do
		@cursor.destroy
		$window.switch_game_state(text)
		end
	end

	def text
		puts "jupp"
	end
end

class Menu_new < Chingu::GameObject
	trait :bounding_box 
	traits :collision_detection

	def setup
		@image = Gosu::Image["./buttons/new_char_button.png"]
		@x = 350
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