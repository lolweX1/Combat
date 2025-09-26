extends CanvasLayer

@onready var player = get_node("/root/Main/Game/Player")

# the upgrades parents in order
const UPGRADES = [
	"Damage",
	"Acceleration",
	"Defense",
	"Control",
	"AtkSpeed",
	"Crit"
]

var levels_png = [
	preload("res://Upgrade_levels/lv1.png"),
	preload("res://Upgrade_levels/lv2.png"),
	preload("res://Upgrade_levels/lv3.png"),
	preload("res://Upgrade_levels/lv4.png"),
	preload("res://Upgrade_levels/lv5.png"),
	preload("res://Upgrade_levels/lv6.png"),
	preload("res://Upgrade_levels/lv7.png"),
	preload("res://Upgrade_levels/lv8.png"),
	preload("res://Upgrade_levels/lv9.png"),
	preload("res://Upgrade_levels/lv10.png")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/Settings_screen/bg/Sensitivity/Value.text = str(player.mouse_horizontal_sens)
	$Control/Settings_screen/bg/Sensitivity/HSlider.max_value = player.get_level(3)*100
	$Control/Settings_screen/bg/Sensitivity/HSlider.value = player.mouse_horizontal_sens * 1000
	print(player.mouse_horizontal_sens)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Control/Settings_screen/bg/Sensitivity/Value.text = str(($Control/Settings_screen/bg/Sensitivity/HSlider.value)/1000.0)


func _on_upgrades_pressed() -> void:
	Global.in_menu = true;
	$Control/Upgrade_screen.visible = true;
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# button function to detect if there are any upgrades
# also used to update any variables that relate to buttons
func _on_add_pressed(arg: int) -> void:
	get_node("/root/Main/Game/Player").add_level(arg, 1)
	get_node("Control/Upgrade_screen/bg/" + UPGRADES[arg] + "_section/TextureRect").texture = levels_png[player.get_level(arg)-1]
	$Control/Settings_screen/bg/Sensitivity/HSlider.max_value = player.get_level(3)*100
	print(player.get_level(3)*100)


func _on_exit_pressed() -> void:
	$Control/Upgrade_screen.visible = false;
	$Control/Settings_screen.visible = false;
	Global.in_menu = false;


func _on_settings_pressed() -> void:
	Global.in_menu = true;
	$Control/Settings_screen.visible = true;
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_h_slider_sens_value_changed(value: float) -> void:
	player.mouse_horizontal_sens = ($Control/Settings_screen/bg/Sensitivity/HSlider.value)/1000.0
