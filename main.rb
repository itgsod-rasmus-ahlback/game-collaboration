require 'chingu'
file = Dir.glob("./*.rb")
file.each do |file_object|
	require file_object
end

include Gosu
include Chingu

class Game < Chingu::Window
	def initialize
		super
		push_game_state(MainMenu)
	end

	def needs_cursor?
		false
	end
end


Game.new.show