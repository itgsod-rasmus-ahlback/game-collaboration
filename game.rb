require "chingu"

include Gosu
include Chingu
		@@windowX,  @@windowY = 800, 600
		@@ball = false
		@@font = "pixelated"
		@@size = 20

class MorganGame < Chingu::GameState
	def initialize
		super
		BackgroundBB.create
		Logo.create(:x => 320, :y => 0, :image => "lib/logo.png")
		SimpleMenu.create(:y => 600, :factor => 2, :menu_items => {"New Game" => :new, "Exit" => :back})
	end

	def back
		pop_game_state
	puts "objects before: #{game_objects.visible_game_objects}"
	game_objects.destroy_all
	puts "objects after: #{game_objects.visible_game_objects}"
		switch_game_state(StartGame)
	end
	def new
		$window.switch_game_state(MorganGame2)
	end
end

class Logo < Chingu::BasicGameObject
  trait :simple_sprite
end

class Score < Chingu::BasicGameObject
	trait :simple_sprite
end


class MorganGame2 < Chingu::GameState
	#Constructor
	def initialize
		@auto = true
		@lock = false
		@@windowX,  @@windowY = 800, 600
		@@ball = false
		@score = 0
		super
		load_game_objects(:file => "levels/level1.yml")
		self.input = {esc: :back, e: :edit, a: :auto}

		BackgroundBB.create(:zorder => 0)
		Score.create(:x => 48, :y => 17, :image => "lib/score.png")
		@scoretext = Text.create(@score)
		@paddle = Paddle.create(:factor_x => 2)
		@brick = GreenBrick
	end


	def auto
		if @auto == true
			@auto = false
		else
			@auto = true
		end
	end

	def edit
		push_game_state(GameStates::Edit.new( :file => "levels/level1.yml", :classes => [YellowBrick, PinkBrick, GreenBrick, OrangeBrick, RedBrick, BlueBrick, BrownBrick, PurpleBrick]))
	end

	def back
	pop_game_state
	puts "objects before: #{game_objects.visible_game_objects}"
	game_objects.destroy_all
	puts "objects after: #{game_objects.visible_game_objects}"
		switch_game_state(StartGame)
	end

	def update

		if $window.mouse_x < 0 then $window.mouse_x = 0 end
		if $window.mouse_x > @@windowX then $window.mouse_x = @@windowX end

		if $window.mouse_y < 0 then $window.mouse_y = 0 end
		if $window.mouse_y > @@windowY then $window.mouse_y = @@windowY end




		if YellowBrick.size == 0 and PinkBrick.size == 0 and GreenBrick.size == 0 and OrangeBrick.size == 0 and RedBrick.size == 0 and BlueBrick.size == 0 and BrownBrick.size == 0 and PurpleBrick.size == 0
			if @lock == false then Text.create("Congratulations You Won!", :x => @@windowX/2, :y => @@windowY/2, :factor => 2) end
				@lock = true
			Ball.each do |kill_ball|
				kill_ball.destroy
			end
			$window.switch_game_state(MorganGame2)
		end
		super

		Paddle.each_bounding_box_collision(Powerup) do |paddle, powerup|

			if powerup.power == 1 then @paddle.factor_x = 3 end #growthpower
			if powerup.power == 2 then @paddle.factor_x = 1 end #Shrinkpower
			powerup.destroy
		end
		if @auto == true
			Ball.each do |ball|
				@paddle.x = ball.x
			end
			$window.mouse_x = @paddle.x
		end


		Ball.each_bounding_box_collision(Paddle) do |ball, paddle|
			Gosu::Sound.new("lib/bounce.wav").play
			ball.bounce(@paddle.vel)
		end

        #Changes the collision type based on the block the ball hits
		Ball.each_bounding_box_collision(GreenBrick) {@brick = GreenBrick} #1
		Ball.each_bounding_box_collision(BlueBrick) {@brick = BlueBrick} #2
		Ball.each_bounding_box_collision(YellowBrick) {@brick = YellowBrick} #3
		Ball.each_bounding_box_collision(RedBrick) {@brick = RedBrick} #4
		Ball.each_bounding_box_collision(BrownBrick) {@brick = BrownBrick} #5
		Ball.each_bounding_box_collision(OrangeBrick) {@brick = OrangeBrick} #6
		Ball.each_bounding_box_collision(PinkBrick) {@brick = PinkBrick} #7
		Ball.each_bounding_box_collision(PurpleBrick) {@brick = PurpleBrick}


		#destroys the block, play a little sound then bounce the ball.
		Ball.each_bounding_box_collision(@brick) do |ball, brick|
			ball.bounce
			brick.destroy
			@score += 1
				Gosu::Sound.new("lib/destroy.wav").play
				powerup = rand(100)

				if powerup.between?(1, 10)
					Powerup.create(x: brick.x, y: brick.y)
				end
		end
		@scoretext.destroy
		@scoretext = Text.create(@score, :x => 145, :y => 9, :factor => 2, :zoder => 10)
		$window.caption = "FPS: #{$window.fps} Score: #{@score}"
	end

end
class BackgroundBB < Chingu::GameObject
	def setup
		@x, @y = @@windowX /2, @@windowY / 2 + 50
		@image = Image["./lib/background.png"]
	end
end


class Paddle < Chingu::GameObject
	attr_accessor :vel, :ball_exist, :shootupgrade
	has_traits :collision_detection, :bounding_box, :timer, :effect
	#meta-constructor
	def setup
		@x, @y = @@windowX / 2, @@windowY - 50
		@shootupgrade = false
		@image = Image["./lib/paddle.png"]
		@vel = 0
		@speed = 10
		@moving = false
		self.scale = 2
		self.factor_x = 2
		self.input = {mouse_left: :launch}
		launch
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
			@@ball = false
		end
	end
end

class Ball < Chingu::GameObject

	has_traits :velocity, :collision_detection, :bounding_box, :timer, :effect

	def setup
		@lock = false
		@image = Image["./lib/ball1.png"]
		self.scale = 2
		self.velocity_y = -10
	end

	def update
		after(20) {@lock = false}
		puts @lock
		if self.y <= 0 + 111
		self.velocity_y *= -1
		Gosu::Sound.new("lib/bounce.wav").play
		end
		if self.x <= 11 or self.x >= @@windowX - 11 
			self.velocity_x *= -1
			Gosu::Sound.new("lib/bounce.wav").play
		end
		if self.y >= @@windowY
			@@ball = false
			self.destroy
			Gosu::Sound.new("lib/missed.wav").play
		end
	end

	def bounce(x = 0)
		if x == 0 then x = rand(-1..1) end
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


