extends Node2D

@onready var player: Player = $Player
@onready var music: AudioStreamPlayer = $Music

func _ready() -> void:
	ScoreManager.reset_score()
	SignalManager.on_player_died.connect(on_player_died)

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE) == true:
		GameManager.load_main_scene()
	if Input.is_action_just_pressed("maker"):
		SignalManager.on_create_bullet.emit(
			Vector2(200, 200),
			Vector2.DOWN,
			100,
			BaseBullet.BULLET_TYPE.ENEMY
		)
	if Input.is_action_just_pressed("generatePowerUp"):
		SignalManager.on_create_powerup.emit(
			Vector2(200, 200),
			 PowerUp.PowerUpType.SHIELD
		)

func on_player_died() -> void:
	music.stop()
	for n in get_tree().get_nodes_in_group(GameManager.GROUP_MOVEABLE):
		if is_instance_valid(n):
			n.queue_free()
	
	var player: Player = get_tree().get_first_node_in_group(GameManager.GROUP_PLAYER)
	if player:
		player.queue_free()
