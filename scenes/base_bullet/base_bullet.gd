extends HitBox

class_name BaseBullet

enum BULLET_TYPE { PLAYER, ENEMY, ENEMY_BOMB }

@export var bullet_type: BULLET_TYPE = BULLET_TYPE.PLAYER

var _direction: Vector2 = Vector2.UP
var _speed: float = 200.0

func _process(delta: float) -> void:
	position += delta * _speed * _direction

func setup(dir: Vector2, speed: float) -> void:
	_direction = dir.normalized()
	_speed = speed

func blow_up() -> void:
	set_process(false)
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	blow_up()

func _on_screen_exited() -> void:
	queue_free()
