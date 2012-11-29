class MainMenu < Chingu::GameState
	def initialize
		super
		@menu = []
		@menu << Menu_start.create
		@menu << Menu_exit.create
		@menu << Menu_chars.create
		@cursor = Cursor.create
		MenuBackground.create
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
