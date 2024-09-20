extends AnimatedSprite2D

class_name Explosion

enum ExplosionType { EXPLOSION, BOOM }

const BOOM: String = "boom"
const EXPLOSION: String = "explosion"

@onready var sound: AudioStreamPlayer2D = $Sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_explosion_random(sound)
	play()

func setup(type: ExplosionType) -> void:
	match type:
		ExplosionType.BOOM:
			animation = BOOM
			scale = Vector2(0.5,0.5)
		ExplosionType.EXPLOSION:
			scale = Vector2(0.75,0.75)
			animation = EXPLOSION

func _on_animation_finished() -> void:
	queue_free()
