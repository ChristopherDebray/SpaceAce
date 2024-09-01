extends Node

# Allows to delete the elements if they go out of screen for a set timer

@export var life_s: float = 30.0

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time = life_s
	timer.start()

func _on_timer_timeout() -> void:
	var p: Node = get_parent()
	p.queue_free()
