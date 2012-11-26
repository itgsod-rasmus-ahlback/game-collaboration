class StartGame < Chingu::GameState
	def initialize
		super
		@menu = [Menu_exit.create,Menu_back.create,Menu_load.create,Menu_new.create]
		@cursor = Cursor.create

	end

	def setup
		self.input = {esc: :exit, mouse_left: :next}
	end

	def next
		@menu.each do |menu|
			@cursor.each_collision(@menu) do
				menu.check
			end
		end
	end
end