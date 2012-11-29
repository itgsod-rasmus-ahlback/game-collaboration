class MenuBackground < Chingu::GameObject
	has_traits :timer
	def setup
		@x = 400
		@y = 300
		@zorder = -10
		@image = Gosu::Image["./menus/menu_pics/menu_background.png"]
		Meteor.create
	end
end

class Meteor < Chingu::GameObject
	has_traits :velocity, :timer
	def setup
		@image = Gosu::Image["./menus/menu_pics/meteor.png"]
		random_number = rand(0..1)

		if random_number == 1
			@y = 0
			@x = rand(800)
		elsif random_number == 0
			@y = rand(600)
			@x = 0
		end

		@speed = rand(1..3)
		@angle = rand(90..179)
		self.velocity_y = Gosu::offset_y(@angle, @speed)
		self.velocity_x = Gosu::offset_x(@angle, @speed)
		self.zorder = 10
			after(10000) do
				# Twinkle.create(x: @x, y: @y)
				self.destroy
				Meteor.create
			end
	end
end

# class Twinkle < Chingu::GameObject
# 	has_traits :timer
# 	def setup
# 		@image = Gosu::Image["./menu_pics/Twinkle.png"]
# 		#@image2 = Gosu::Image["./menus/menu_pic/twinkle_2.png"]
# 		after(2000) do
# 			self.destroy
# 		end
# 	end
# end
