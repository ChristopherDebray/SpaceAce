extends Resource

class_name EnemyWaves

# Is used for the manager to loop around and spawn the waves
@export var waves: Array[EnemyWave]

# Allows to loop, if the seeked wave is greater than the count, this will return the first wave etc
func get_wave_for_wave_count(wc: int) -> EnemyWave:
	return waves[wc % waves.size()]

func wave_is_start(wc: int) -> bool:
	return wc % waves.size() == 0
