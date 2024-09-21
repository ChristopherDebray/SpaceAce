extends Control

@onready var score_label: Label = $VBoxContainer/ScoreLabel
@onready var h_score_label: Label = $VBoxContainer/HScoreLabel
@onready var replay_label: Label = $VBoxContainer/ReplayLabel
@onready var timer: Timer = $Timer

var is_replay_enabled: bool = false

func _ready() -> void:
	SignalManager.on_player_died.connect(on_player_died)
	set_process(false)

func _process(delta: float) -> void:
	if is_replay_enabled == false:
		return
	
	if Input.is_action_just_pressed("shoot"):
		GameManager.load_main_scene()

func on_player_died() -> void:
	score_label.text = 'Score : %d' % ScoreManager.get_score()
	h_score_label.text = 'Hight score : %d' % ScoreManager.get_high_score()
	show()
	timer.start()
	set_process(true)

func _on_timer_timeout() -> void:
	replay_label.text = "Press shoot to exit to the main menu"
	is_replay_enabled = true
