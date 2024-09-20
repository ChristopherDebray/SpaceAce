extends PathFollow2D

class_name BaseEnemy

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var _speed: float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotates = false
	loop = false
	SpaceUtils.play_random_animation(animated_sprite_2d)

func _process(delta: float) -> void:
	progress += delta * _speed
	if progress_ratio > 0.99:
		queue_free()

func setup(speed: float) -> void:
	_speed = speed
