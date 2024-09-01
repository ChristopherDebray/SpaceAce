extends Node2D

@onready var player: Player = $Player

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE) == true:
		GameManager.load_main_scene()
	if Input.is_action_just_pressed("maker"):
		SignalManager.on_create_bullet.emit(
			Vector2(200, 200),
			Vector2.DOWN,
			100,
			BaseBullet.BULLET_TYPE.PLAYER
		)
	if Input.is_action_just_pressed("generatePowerUp"):
		SignalManager.on_create_powerup.emit(
			Vector2(200, 200),
			 PowerUp.PowerUpType.HEALTH
		)
