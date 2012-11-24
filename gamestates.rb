class MainMenu < Chingu::GameState
	def initialize
		super
		@counter = 1
		@menu1 = Menu_item1.create
		@menu2 = Menu_item2.create
		@cursor = Cursor.create
		@list = []
	end

	def setup
		self.input = {esc: :exit, holding_mouse_left: :next}
	end

	def next
		@cursor.each_collision(@menu1) do 
			switch_game_state(StartGame)
		end
		@cursor.each_collision(@menu2) do
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
		puts "switch"
		self.input = {esc: :exit}
	end
end