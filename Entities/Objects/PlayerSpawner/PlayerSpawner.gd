extends Node2D


func _ready():
	GSM.connect("spawn_player", self, "spawn_player")


func spawn_player(run_id, save_count_total):
	var player_instance = preload("res://Entities/Characters/Player/Player.tscn").instance()
	player_instance.id = run_id
	add_child(player_instance)
	GSM.emit_signal("init_params", save_count_total)
