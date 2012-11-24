class MainMenu < Chingu::GameState
	def initialize
		super
		@counter = 1
		@menu1 = Menu_item1.create
		@cursor = Cursor.create
		@list = []
	end

	def setup
		Text.create("Click the cloud", x: 300, y: 400)
		self.input = {esc: :exit, holding_mouse_left: :next}
	end

	def next
		@cursor.each_collision(@menu1) do 
			switch_game_state(StartGame)
		end
	end
end


class StartGame < Chingu::GameState
	def initialize
		super
	end

	def setup
		puts "switch"
		self.input = {esc: :exit}
	end
end