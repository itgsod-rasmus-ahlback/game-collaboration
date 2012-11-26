class StartGame < Chingu::GameState
	def initialize
		super
		Cursor.create
		@exit = Menu_exit.create
		@back = Menu_back.create
		@load = Menu_load.create
		@new = Menu_new.create
		@cursor = Cursor.create

	end

	def setup
		self.input = {esc: :exit, mouse_left: :next}
	end

	def next
		@cursor.each_collision(@exit) do 
			exit
		end
		@cursor.each_collision(@back) do 
			switch_game_state(MainMenu)
		end
		@cursor.each_collision(@load) do 
			puts "hej"
		end
		@cursor.each_collision(@new) do
			@cursor.destroy
			switch_game_state(Gameplay)
		end

		@cursor.each_collision() do 
			puts "lol"
		end
	end
end