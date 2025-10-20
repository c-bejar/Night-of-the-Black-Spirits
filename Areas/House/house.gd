extends Node2D

const TVScene: PackedScene = preload("res://Entities/TV/tv.tscn")
const MAX_TVS: int = 6

var bodies_in_range: Array = []

func _ready() -> void:
	for i: int in range(MAX_TVS):
		spawn_tv()

func spawn_tv() -> void:
	var markers: Array = $"SpawnPoints".get_children()
	var marker_pos: Vector2
	while true:
		var rand_val: int = randi() % markers.size()
		marker_pos = markers[rand_val].global_position
		if marker_pos not in Globals.spawns:
			break
	if marker_pos not in Globals.spawns:
		Globals.spawns.append(marker_pos)
		var TVInstance: StaticBody2D = TVScene.instantiate()
		TVInstance.global_position = marker_pos
		TVInstance.tv_died.connect(spawn_tv)
		$TVs.add_child(TVInstance)


func _on_player_axe_attack() -> void:
	for body: PhysicsBody2D in bodies_in_range:
		if "tv_destroyed" in body:
			Globals.spawns.erase(body.global_position)
			body.tv_destroyed(true)
		elif "hit" in body:
			body.hit()


func _on_player_tv_entered(body: Node2D) -> void:
	bodies_in_range.append(body)


func _on_player_tv_exited(body: Node2D) -> void:
	bodies_in_range.erase(body)


func _on_player_game_has_ended() -> void:
	for body: PhysicsBody2D in self.get_tree().get_nodes_in_group("to_be_removed"):
		body.queue_free()
	$Player.hide_all()
