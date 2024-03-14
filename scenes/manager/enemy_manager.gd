extends Node

# Game Window Size currently 640 wide -> 640/2 = 320 -> 320 + 10 = 330 -> make sure the enemies spawn outside of Game Window (also considering window corners)
const SPAWN_RADIUS = 375

@export var basic_enemy_scene: PackedScene

func _ready():
	$Timer.timeout.connect(on_timer_timeout)

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	# always check for player, since he might be dead e.g.
	if player == null:
		return
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
	
	var enemy = basic_enemy_scene.instantiate() as Node2D
	# parent of EnemyManager Node is going to be the main scene
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position
