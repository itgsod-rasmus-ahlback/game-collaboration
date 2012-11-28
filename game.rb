require "chingu"

include Gosu
include Chingu
		@@windowX,  @@windowY = 800, 600
		@@ball = false





class MorganGame < Chingu::GameState
	#Constructor
	def initialize
		@lock = false
		@@windowX,  @@windowY = 800, 600
		@@ball = false
		super
		load_game_objects
		self.input = {esc: :back, e: :edit}
		BackgroundBB.create(:zorder => 0)
		@paddle = Paddle.create(:factor_x => 2)
		@score = 0
		@brick = MetalBrick
	end


	def edit
		 push_game_state(GameStates::Edit.new(:grid => [32,32], :classes => [RegularBrick, MetalBrick, HardBrick, MediumBrick]))
	end

	def back
	pop_game_state
	puts "objects before: #{game_objects.visible_game_objects}"
	game_objects.destroy_all
	puts "objects after: #{game_objects.visible_game_objects}"
		switch_game_state(StartGame)
	end

	def update

		if RegularBrick.size == 0 and @lock != true then Text.create("You Win! you got a score of #{@score}", x: 500, y: 100) and @lock = true end
		if RegularBrick.size == 0
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


		Ball.each_bounding_box_collision(RegularBrick) {@brick = RegularBrick} 
		Ball.each_bounding_box_collision(MetalBrick) {@brick = MetalBrick} 
		Ball.each_bounding_box_collision(HardBrick) {@brick = HardBrick} 
		Ball.each_bounding_box_collision(MediumBrick) {@brick = MediumBrick} 


		Ball.each_bounding_box_collision(@brick) do |ball, brick|
			ball.bounce
			if @brick == RegularBrick
				powerup = rand(100)

				if powerup.between?(1, 10)
					Powerup.create(x: brick.x, y: brick.y)
				end
					brick.destroy
					@score += 1
			elsif @brick == HardBrick
				powerup = rand(100)
				if powerup.between?(1, 10)
					Powerup.create(x: brick.x, y: brick.y)
				end
				MediumBrick.create(x: brick.x, y: brick.y)
				brick.destroy
				@score += 1

			elsif @brick == MediumBrick
				powerup = rand(100)
				if powerup.between?(1, 10)
					Powerup.create(x: brick.x, y: brick.y)
				end
				RegularBrick.create(x: brick.x, y: brick.y)
				brick.destroy
				@score += 1

			end
		end
		$window.caption = "FPS: #{$window.fps} Score: #{@score}"
	end

end

class BackgroundBB < Chingu::GameObject
	def setup
		@x, @y = @@windowX /2, @@windowY / 2
		@image = Image["./lib/background.jpg"]
	end
end

class Paddle < Chingu::GameObject
	attr_accessor :vel, :ball_exist, :shootupgrade
	has_traits :collision_detection, :bounding_box, :timer
	#meta-constructor
	def setup
		@x, @y = @@windowX / 2, @@windowY - 7.5
		@shootupgrade = false
		@image = Image["./lib/paddle.png"]
		@vel = 0
		@speed = 10
		@moving = false
		self.input = {mouse_left: :launch}
	end


	def update


		if @shootupgrade == true 
			after (4500) {@image = Image[".lib/paddle.png"]}
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

	has_traits :velocity, :collision_detection, :bounding_box, :timer

	def setup
		@lock = false
		@image = Image["./lib/ball#{rand(2..4)}.png"]
		self.velocity_y = -20
	end

	def update
		after(10) {@lock = false}
		puts @lock
		if self.y <= 0 then self.velocity_y *= -1 end
		if self.x <= 0 or self.x >= @@windowX then self.velocity_x *= -1 end
		if self.y >= @@windowY
			@@ball = false
			self.destroy
		end
	end

	def bounce(x = 0)
		unless @lock
			if x > 0 and x < 5
				self.velocity_x += x
			elsif x < 0 and x > -5
				self.velocity_x -= x
			elsif x > 5 or x < - 5
				self.velocity_x = x
			end 
			self.velocity_y *= -1
			@lock = true
			
			puts "x = #{x}"
		end
	end
end


