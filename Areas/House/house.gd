extends Node2D

const tv_scene: PackedScene = preload("res://Entities/TV/tv.tscn")

var total_tvs: int = 0
var spawns: Array = []
var tvs_in_range: Array = []

func _ready() -> void:
	var children: Array = $"SpawnPoints".get_children()
	while total_tvs < 6:
		var rand_val: int = randi() % children.size()
		if children[rand_val].global_position not in spawns:
			spawns.append(children[rand_val].global_position)
			total_tvs += 1
	print(spawns)
	for spawn: Vector2 in spawns:
		var tv_instance: StaticBody2D = tv_scene.instantiate()
		tv_instance.position = spawn
		$".".add_child(tv_instance)

func _on_player_axe_attack() -> void:
	for tv: StaticBody2D in tvs_in_range:
		if "tv_destroyed" in tv:
			tv.tv_destroyed()


func _on_player_tv_entered(body: Node2D) -> void:
	tvs_in_range.append(body)


func _on_player_tv_exited(body: Node2D) -> void:
	tvs_in_range.erase(body)
