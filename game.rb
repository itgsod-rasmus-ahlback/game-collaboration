require "chingu"
		@@windowX,  @@windowY = 800, 600
		@@ball = false
class MorganGame < Chingu::GameState
	#Constructor
	def initialize
		@lock = false
		@@windowX,  @@windowY = 800, 600
		@@ball = false
		super
		self.input = {esc: :back, :e :edit}
		Background_BB.create
		@paddle = Paddle.create(:factor_x => 2)
		@score = 0
		x = rand(32..50)
		y = 12 * 3
		puts fps
		rand(20..40).times do
			Brick.create(x: x, y: y)
			x += rand(64..70)
			if x >= @@windowX - 50
				y += 30
				x = rand(32..50)
			end
		end
		Brick.each do |brick|
			brick.imgchange(rand(0..2)) 
		end
	end

	def back
		pop_game_state
		Brick.each do |brick|
			brick.destroy
		end
		Ball.each do |ball|
			ball.destroy
		end
		Paddle.each do |paddle|
			paddle.destroy
		end
		switch_game_state(StartGame)
	end

	def update
		if Brick.size == 0 and @lock != true then Text.create("You Win! you got a score of #{@score}", x: 500, y: 100) and @lock = true end
		if Brick.size == 0
			Ball.each do |kill_ball|
				kill_ball.destroy
			end
		end
		super

		Paddle.each_bounding_box_collision(Powerup) do |paddle, powerup|

			if powerup.power == 1 then @paddle.factor_x = 3 end
			if powerup.power == 2 then @paddle.factor_x = 1 end
			powerup.destroy
		end


		Ball.each_bounding_box_collision(Paddle) do |ball, paddle|
			ball.bounce(@paddle.vel)
		end
		Ball.each_bounding_box_collision(Brick) do |ball, brick|
			ball.bounce

			powerup = rand(100)

			if powerup.between?(1, 10)
				Powerup.create(x: brick.x, y: brick.y)
			end
			img = brick.img
			if img == 0
				brick.destroy
				@score += 1
			else
				brick.imgchange(img - 1)
				@score += 1
			end

		end
		$window.caption = "FPS: #{$window.fps} Score: #{@score}"
	end

end

class Background_BB < Chingu::GameObject
	def setup
		@x, @y = @@windowX /2, @@windowY / 2
		@image = Gosu::Image["./lib/background.jpg"]
	end
end

class Paddle < Chingu::GameObject
	attr_accessor :vel, :ball_exist, :shootupgrade
	has_traits :collision_detection, :bounding_box, :timer
	#meta-constructor
	def setup
		@x, @y = @@windowX / 2, @@windowY - 7.5
		@shootupgrade = false
		@image = Gosu::Image["./lib/paddle.png"]
		@vel = 0
		@speed = 10
		@moving = false
		self.input = {mouse_left: :launch}
	end


	def update


		if @shootupgrade == true 
			after (4500) {@image = Gosu::Image[".lib/paddle.png"]}
		end

		if x != $window.mouse_x
		@moving = true
		@vel = ($window.mouse_x - @x) / 2
		@x = $window.mouse_x
		end

		if self.factor_x > 2 or self.factor_x < 2
			after(4500) {self.factor_x = 2}
		end

		if @x < 0 + (@image.width * self.factor_x )/ 2 then @x = 0 + (@image.width * self.factor_x )/ 2 end
		if @x > @@windowX - (@image.width * self.factor_x )/ 2 then @x = @@windowX - (@image.width * self.factor_x )/ 2 end

		if @moving == false then @vel = 0 end
		@moving = false
		if @vel > 10 then @vel = 10 end
			if @vel < -10 then @vel = -10 end
	end


	def launch
		if @@ball == false
			Ball.create(x: self.x, y: self.y - 25, velocity_x: @vel)
			@@ball = true
		end
	end
end

class Ball < Chingu::GameObject

	has_traits :velocity, :collision_detection, :bounding_box

	def setup
		@image = Gosu::Image["./lib/ball#{rand(2..4)}.png"]
		self.velocity_y = -20
	end

	def update
		if self.y <= 0 then self.velocity_y *= -1 end
		if self.x <= 0 or self.x >= @@windowX then self.velocity_x *= -1 end
		if self.y >= @@windowY
			@@ball = false
			self.destroy
		end
	end

	def bounce(x = 0)
		if x > 0 and x < 5
			self.velocity_x += x
		elsif x < 0 and x > -5
			self.velocity_x -= x
		elsif x > 5 or x < - 5
			self.velocity_x = x
		end 
		self.velocity_y *= -1
		
		puts "x = #{x}"
	end
end

class Brick < Chingu::GameObject
	attr_reader :x, :y, :img
	has_traits :collision_detection, :bounding_box
	def setup
		@img = 0
	end

	def imgchange (img)
		if img == 0 then image = "./lib/bricks/brick.png" end
		if img == 1 then image = "./lib/bricks/brickbroken.png" end
		if img == 2 then image = "./lib/bricks/brickhard.png" end
		@img = img
		@image = Gosu::Image[image]
	end

end