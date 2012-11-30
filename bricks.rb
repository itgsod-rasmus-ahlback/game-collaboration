class Brick < Chingu::GameObject
		has_traits :collision_detection, :bounding_box, :effect
	def setup
		@image = Image["./lib/bricks/#{self.filename}.png"]
		self.scale = 1
	end
end



class YellowBrick < Brick; end
class PinkBrick < Brick; end
class GreenBrick < Brick; end
class OrangeBrick < Brick; end
class RedBrick < Brick; end
class BlueBrick < Brick; end
class BrownBrick < Brick; end
class PurpleBrick < Brick; end