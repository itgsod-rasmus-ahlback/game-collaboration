class MainMenu < Chingu::GameState
	def initialize
		super
		@menu1 = Menu_start.create
		@menu2 = Menu_exit.create
		@menu3 = Menu_chars.create
		@cursor = Cursor.create
	end

	def setup
		self.input = {esc: :exit, mouse_left: :next}
	end

	def next
		@cursor.each_collision(@menu1) do 
			switch_game_state(StartGame)
		end
		@cursor.each_collision(@menu2) do
			exit
		end
		@cursor.each_collision(@menu3) do
			switch_game_state(List_characters)
		end
	end

end
