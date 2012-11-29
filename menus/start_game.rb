class StartGame < Chingu::GameState
	# def initialize
	# 	super
	# 	@menu = [Menu_exit.create,Menu_back.create,Menu_load.create,Menu_new.create]
	# 	@menu << Menu_lund.create
	# 	@cursor = Cursor.create

	# end

	def setup
		self.input = {esc: :exit, mouse_left: :next}
		@menu = [Menu_exit.create,Menu_load.create,Menu_new.create]
		@menu << Menu_lund.create
		@menu << Menu_back.create
		@cursor = Cursor.create
		MenuBackground.create
	end

	def next
		@menu.each do |menu|
			@cursor.each_collision(@menu) do
				menu.check
			end
		end
	end

	def update
		super
		$window.caption = "Selection screen, FPS: #{$window.fps}"
	end
end