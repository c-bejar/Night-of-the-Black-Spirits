extends Node2D

const TVScene: PackedScene = preload("res://Entities/TV/tv.tscn")
const MAX_TVS: int = 6

var total_tvs: int = 0
var spawns: Array = []
var tvs_in_range: Array = []

func _ready() -> void:
	spawn_tvs()


func _process(_delta: float) -> void:
	if total_tvs < MAX_TVS:
		spawn_tvs()


func spawn_tvs() -> void:
	var children: Array = $"SpawnPoints".get_children()
	var total_locs: int = children.size()
	while total_tvs < MAX_TVS:
		var rand_val: int = randi() % total_locs
		if children[rand_val].global_position not in spawns:
			spawns.append(children[rand_val].global_position)
			var TVInstance: StaticBody2D = TVScene.instantiate()
			TVInstance.global_position = children[rand_val].global_position
			$".".add_child(TVInstance)
			total_tvs += 1


func _on_player_axe_attack() -> void:
	for tv: StaticBody2D in tvs_in_range:
		if "tv_destroyed" in tv:
			spawns.erase(tv.global_position)
			total_tvs -= 1
			tv.tv_destroyed()


func _on_player_tv_entered(body: Node2D) -> void:
	tvs_in_range.append(body)


func _on_player_tv_exited(body: Node2D) -> void:
	tvs_in_range.erase(body)
