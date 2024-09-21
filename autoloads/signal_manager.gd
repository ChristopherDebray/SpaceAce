extends Node

signal on_create_bullet(start_pos: Vector2, dir: Vector2, speed: float, bu_type: BaseBullet.BULLET_TYPE)
signal on_create_powerup(start_pos: Vector2, pu_type: PowerUp.PowerUpType)
signal on_create_random_powerup(start_pos: Vector2)
signal on_create_explosion(start_pos: Vector2, exp_type: Explosion.ExplosionType)
signal on_player_hit(damage: int)
signal on_player_died()
signal on_player_health_bonus(v: int)
signal on_score_updated(v: int)
