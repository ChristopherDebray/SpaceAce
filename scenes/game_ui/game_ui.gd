extends Control

@onready var health_bar: HealthBar = $ColorRect/MarginContainer/HealthBar
@onready var score_label: Label = $ColorRect/MarginContainer/ScoreLabel
@onready var sound: AudioStreamPlayer2D = $Sound

func _ready() -> void:
	SignalManager.on_player_hit.connect(on_player_hit)
	SignalManager.on_player_health_bonus.connect(on_player_health_bonus)
	SignalManager.on_score_updated.connect(on_score_updated)

func _process(delta: float) -> void:
	pass

func on_player_hit(damage: int) -> void:
	health_bar.take_damage(damage)

func _on_player_died() -> void:
	SignalManager.on_player_died.emit()

func on_player_health_bonus(health_boost: int) -> void:
	health_bar.incr_value(health_boost)
	SoundManager.play_power_up_sound(PowerUp.PowerUpType.HEALTH, sound)

func on_score_updated(score: int) -> void:
	score_label.text = "%06d" % score
