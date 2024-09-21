extends ParallaxBackground

const SPEED: float = 50.0

@onready var stars_1: ParallaxLayer = $Stars1
@onready var stars_2: ParallaxLayer = $Stars2
@onready var stars_3: ParallaxLayer = $Stars3

func _process(delta: float) -> void:
	# We cannot do this anymore since we now use a shake camera.
	# scroll_offset is affected by camera 2d, before we didn't have one
	# scroll_offset.y += delta * SPEED
	stars_1.motion_offset.y += SPEED * delta * 0.2
	stars_2.motion_offset.y += SPEED * delta * 0.3
	stars_3.motion_offset.y += SPEED * delta * 0.33
