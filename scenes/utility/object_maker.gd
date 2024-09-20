extends Node2D

const ENEMY_BOMB = preload("res://scenes/base_bullet/enemy_bomb.tscn")
const ENEMY_BULLET = preload("res://scenes/base_bullet/enemy_bullet.tscn")
const PLAYER_BULLET = preload("res://scenes/base_bullet/player_bullet.tscn")
const POWER_UP = preload("res://scenes/power_up/power_up.tscn")
const EXPLOSION = preload("res://scenes/explosion/explosion.tscn")

const ADD_OBJECT: String = "add_object"

func _ready() -> void:
	SignalManager.on_create_bullet.connect(on_create_bullet)
	SignalManager.on_create_powerup.connect(on_create_powerup)
	SignalManager.on_create_explosion.connect(on_create_explosion)

func add_object(obj: Node, global_position: Vector2) -> void:
	add_child(obj)
	obj.global_position = global_position

func on_create_bullet(start_pos: Vector2, dir: Vector2, speed: float, bu_type: BaseBullet.BULLET_TYPE ) -> void:
	var scene: BaseBullet
	match bu_type:
		BaseBullet.BULLET_TYPE.PLAYER:
			scene = PLAYER_BULLET.instantiate()
		BaseBullet.BULLET_TYPE.ENEMY:
			scene = ENEMY_BULLET.instantiate()
		BaseBullet.BULLET_TYPE.ENEMY_BOMB:
			scene = ENEMY_BOMB.instantiate()
	if scene:
		scene.setup(dir, speed)
		call_deferred(ADD_OBJECT, scene, start_pos)

func on_create_powerup(start_pos: Vector2, type: PowerUp.PowerUpType) -> void:
	var power_up: PowerUp = POWER_UP.instantiate()
	power_up.set_type(type)
	call_deferred(ADD_OBJECT, power_up, start_pos)
	

func on_create_explosion(start_pos: Vector2, type: Explosion.ExplosionType) -> void:
	var explosion: Explosion = EXPLOSION.instantiate()
	explosion.setup(type)
	call_deferred(ADD_OBJECT, explosion, start_pos)
