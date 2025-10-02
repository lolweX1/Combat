extends Node3D

var mesh;
var bullet = preload("res://player_chess_basic_bullet.tscn")
var env;

func _ready() -> void:
	mesh = $King.mesh
	env = get_tree().get_root().get_node("Main/Game/Environment")

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

func basic_atk() -> void: #err
	var blt = bullet.instantiate()
	blt.position = get_parent().position + Vector3(0, 0, 0)
	env.add_child(blt)

func counter() -> void:
	pass
	
func block() -> void:
	pass # no weapons -> dmg mitigation
