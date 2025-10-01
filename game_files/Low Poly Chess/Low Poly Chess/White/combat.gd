extends Node3D

var mesh;
var bullet = preload("res://player_chess_basic_bullet.tscn")

func _ready() -> void:
	mesh = $King.mesh

func get_initial_stats() -> Array:
	return [3, 15, 2, 5, 10, 7]

func get_stat_lvl_mult() -> Array:
	return [3, 10, 1, 10, 3, 8]

func skill(number: int) -> void:
	if (number == 1):
		pass # bishop
	elif (number == 2):
		pass # knight
	elif (number == 3):
		pass # rook

func ult() -> void:
	pass # queen

func basic_atk() -> void:
	var blt = bullet.instantiate()
	blt.transform.origin = Vector3(0, 2, 0)
	blt.apply_inpulse(Vector3(1, 0, 0))
	get_parent().add_child(blt)
	
func counter() -> void:
	pass
	
func block() -> void:
	pass # no weapons -> dmg mitigation
