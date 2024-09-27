extends PathFollow2D

class_name Saucer

const SPEED: float = 20
const WAIT_TIME: float = 6.0
const WAIT_VAR: float = 1.0
const BOOM_DELAY: float = 0.1
const SCORE: int = 150

const PB: String = "parameters/playback"

@onready var shoot_timer: Timer = $ShootTimer
@onready var tree: AnimationTree = $AnimationTree
# The playback is needed to travel between the animations
@onready var s_mach: AnimationNodeStateMachinePlayback = tree[PB]
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var hit_box: HitBox = $HitBox
@onready var collision_shape_2d: CollisionShape2D = $HitBox/CollisionShape2D
@onready var health_bar: HealthBar = $HealthBar
@onready var booms: Node2D = $Booms

var _shooting: bool = false

func _ready() -> void:
	reset_timer()

func _process(delta: float) -> void:
	if _shooting == false:
		progress += SPEED * delta
	
	if progress_ratio > 0.99:
		queue_free()

func deactivate() -> void:
	collision_shape_2d.call_deferred('set_disabled', true)

func shoot() -> void:
	_shooting = true
	s_mach.travel("shoot")
	sound.play()
	SignalManager.on_create_homing_missile.emit(global_position)

func reset_timer() -> void:
	SpaceUtils.set_and_start_timer(shoot_timer, WAIT_TIME, WAIT_VAR)

func stop_shooting() -> void:
	_shooting = false
	reset_timer()

func make_booms() -> void:
	for b in booms.get_children():
		SignalManager.on_create_explosion.emit(b.global_position, Explosion.ExplosionType.BOOM)
		await get_tree().create_timer(BOOM_DELAY).timeout

func _on_shoot_timer_timeout() -> void:
	shoot()

func _on_health_bar_died() -> void:
	health_bar.hide()
	set_process(false)
	# Without we could have the timer ending while we play the die animation
	# Therefore going to the shoot animation and making the Saucer invicible
	shoot_timer.stop()
	#hit_box.deactivate()
	s_mach.travel('die');
	ScoreManager.increment_score(SCORE)
	make_booms()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area is HitBox:
		health_bar.take_damage(area.get_damage())
