extends Area2D

class_name Player

@export var speed: float = 250.0
@export var health_boost: int = 50

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shield: Shield = $Shield

var _lower_left: Vector2
var _lower_right: Vector2

var _stored_power: PowerUp.PowerUpType

const MARGIN: float = 20.0

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
	if Input.is_action_just_pressed("shoot") == true:
		SignalManager.on_create_bullet.emit(
			position,
			Vector2.UP,
			100,
			BaseBullet.BULLET_TYPE.PLAYER
		)
	
	if Input.is_action_just_pressed("item") == true:
		use_power()
	
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

func _on_area_entered(area: Area2D) -> void:
	if area is BaseBullet or area is HomingMissle:
		SignalManager.on_player_hit.emit(area.get_damage())
		return
	
	if area is PowerUp:
		_stored_power = area.get_type()
		return

func use_power() -> void:
	match _stored_power:
		PowerUp.PowerUpType.SHIELD:
			shield.enable_shield()
		PowerUp.PowerUpType.HEALTH:
			SignalManager.on_player_health_bonus.emit(health_boost)
