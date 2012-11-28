class MetalBrick < Chingu::GameObject
		has_traits :collision_detection, :bounding_box
	def setup
		@image = Image["./lib/bricks/Metal.png"]
	end
end



class RegularBrick < Chingu::GameObject
		has_traits :collision_detection, :bounding_box
	def setup
		@image = Image["./lib/bricks/Regular.png"]
	end
end

class HardBrick < Chingu::GameObject
		has_traits :collision_detection, :bounding_box
	def setup
		@image = Image["./lib/bricks/Hard.png"]
	end
end

class MediumBrick < Chingu::GameObject
		has_traits :collision_detection, :bounding_box
	def setup
		@image = Image["./lib/bricks/Medium.png"]
	end
end

