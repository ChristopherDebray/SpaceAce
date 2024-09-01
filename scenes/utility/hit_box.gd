extends Area2D

class_name HitBox

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var damage: int

func deactivate_collision() -> void:
	collision_shape_2d.call_deferred('set_disabled', true)

func get_damage() -> int:
	return damage

func _on_area_entered(area: Area2D) -> void:
	pass
