extends Area2D

class_name Player

@export var speed: float = 250.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _lower_left: Vector2
var _lower_right: Vector2

const MARGIN: float = 50.0

func _ready() -> void:
	set_limits()

func _process(delta: float) -> void:
	var input: Vector2 = get_input()
	
	global_position += input * delta * speed
	global_position = global_position.clamp(
		_lower_left,
		_lower_right
	)

func get_input() -> Vector2:
	var direction: Vector2 = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down"),
	)
	
	if direction.x != 0:
		animation_player.play("turn")
		sprite_2d.flip_h = true if direction.x > 0 else false
	else:
		animation_player.play("fly")
	
	# Without this, the speed would be faster on diagonal movements, this normalizes your direction to prevent that
	return direction.normalized()

func set_limits() -> void:
	var vp: Rect2 = get_viewport_rect()
	_lower_right = Vector2(vp.size.x - MARGIN, vp.size.y - MARGIN)
	_lower_left = Vector2(MARGIN, MARGIN)
