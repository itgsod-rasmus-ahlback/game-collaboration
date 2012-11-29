class MenuBackground < Chingu:GameObject
	has_traits :timer
	def setup
		@image = Gosu::Image["./menus/menu_pic/menu_background.png"]
	end

	def update
		super
		every(1000) do 
			Meteor.create
		end
	end
end

class Meteor < Chingu:GameObject
	has_traits :velocity, :timer
	def setup
		@x = rand(0..800)
		@y = rand(0..600)
		@speed = rand(1..3)
		@angle = rand(0..359)
		self.velocity_y = Gosu::offset_y(@angle, 1)
		self.zorder = 10
		after(1000) do |me|
			me.destroy
		end
	end
end