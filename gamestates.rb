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
		Cursor.each_collision(@menu1) do 
			switch_game_state(StartGame)
		end
		Cursor.each_collision(@menu2) do
			exit
		end
		Cursor.each_collision(@menu3) do
			switch_game_state(List_characters)
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
		@menu1 = Menu_exit.create
		@menu1 = Menu_back.create
	end

	def next
		Cursor.each_collision(@menu1) do 
			switch_game_state(MainMenu)
		end
	end
end




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
		@file.each do |text|
			Text.create(text.gsub(".txt", ""),x: @x, y: @y)
			@list << text
			@y += 20
		end
	end

	def next
		Cursor.each_collision(@menu2) do 
			switch_game_state(MainMenu)
		end
	end
end