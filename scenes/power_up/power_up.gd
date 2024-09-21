extends HitBox

class_name PowerUp

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sound: AudioStreamPlayer2D = $Sound

@export var type: PowerUpType = PowerUpType.SHIELD
@export var speed: float = 50.0

enum PowerUpType { SHIELD, HEALTH }

const TEXTURES: Dictionary = {
	PowerUpType.SHIELD: preload("res://assets/misc/shield_gold.png"),
	PowerUpType.HEALTH: preload("res://assets/misc/powerupGreen_bolt.png"),
}

var _power_type: PowerUpType = type

func _ready() -> void:
	sprite_2d.texture = TEXTURES[_power_type]
	SoundManager.play_powerup_deploy_sound(sound)

func _process(delta: float) -> void:
	position.y += speed * delta

func get_type() -> PowerUpType:
	return _power_type

func set_type(new_type: PowerUpType) -> void:
	_power_type = new_type

func _on_area_entered(area: Area2D) -> void:
	queue_free()
