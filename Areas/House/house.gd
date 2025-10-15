extends Node2D

const tv_scene: PackedScene = preload("res://Entities/TV/tv.tscn")

var total_tvs: int = 0
var spawns: Array = []

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
	

func _process(_delta: float) -> void:
	pass

func get_new_spawn() -> void:
	pass
	
