

class List_characters < Chingu::GameState
	def initialize
		super
		Cursor.create
		@menu2 = Menu_back.create
		@file = Dir.glob("*.txt")
		@x = 50
		@y = 50
		@list = []
	end

	def setup
		self.input = {esc: :exit, mouse_left: :next}
	end

	def next
		Cursor.each_collision(@menu2) do 
			switch_game_state(MainMenu)
		end
	end
end