extends Node2D

@onready var despawnTimer = get_node("%DespawnTimer")

func _ready():
	despawnTimer.wait_time = Global.BULLET_DESPAWN
	despawnTimer.start()

func _process(delta):
	position += transform.x * delta * Global.BULLET_SPEED

func _on_despawn_timer_timeout():
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.playerHit(Global.BULLET_DAMAGE)
		queue_free()
