class MainMenu < Chingu::GameState
	def initialize
		super
		@menu1 = Menu_start.create
		@menu2 = Menu_exit.create
		@cursor = Cursor.create
	end

	def setup
		self.input = {esc: :exit, mouse_left: :next}
	end

	def next
		Cursor.each_collision(@menu1) do 
			switch_game_state(StartGame)
		end
		Cursor.each_collision(@menu2) do
			exit
		end
	end
end



class StartGame < Chingu::GameState
	def initialize
		super
		Cursor.create
	end

	def setup
		self.input = {esc: :exit, mouse_left: :next}
		@menu1 = Menu2_back.create
	end

	def next
		Cursor.each_collision(@menu1) do 
			switch_game_state(MainMenu)
		end
	end
end