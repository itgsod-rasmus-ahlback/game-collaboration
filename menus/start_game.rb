class StartGame < Chingu::GameState
	def initialize
		super
		Cursor.create
		@exit = Menu_exit.create
		@back = Menu_back.create
		@load = Menu_load.create
		@new = Menu_new.create
	end

	def setup
		self.input = {esc: :exit, mouse_left: :next}

	end

	def next
		Cursor.each_collision(@exit) do 
			exit
		end
		Cursor.each_collision(@back) do 
			switch_game_state(MainMenu)
		end
		Cursor.each_collision(@load) do 
			puts "hej"
		end
		Cursor.each_collision(@new) do 
			$window.caption = "Creating new"
		end
	end
end