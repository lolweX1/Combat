extends Node2D

@onready var game = preload("res://Game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_btn_pressed() -> void:
	get_tree().root.get_node("Main").add_child(game.instantiate())
	queue_free()
