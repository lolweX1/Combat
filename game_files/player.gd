extends CharacterBody3D

const MAX_JUMP_VELOCITY = 20
const INITIAL_JUMP_VELOCITY = 4.5

@export var ATK_SPEED = 10
@export var DAMAGE = 10
@export var CONTROL = 1
@export var DEFENSE = 5
@export var CRITICAL = 1
@export var ACCEL = 10

var levels = {
	"atkspd": 1,
	"dmg": 1,
	"ctrl": 1,
	"def": 1,
	"crit": 1,
	"accel": 1
}

# setting mouse sensitivity for player
var mouse_horizontal_sens = 0.1
var mouse_vertical_sens = 0.1

var max_sens = 0.1;

var game_focus = false

# defining vertical camera movement
var current_vert_view = 0;
const DEGREE_OF_VERTICAL_VIEW = 60; # this is how much it can go up or down

const MAX_LEVEL = 10;

var chara

func level_change(level_name: String, increment: int) -> int:
	levels[level_name] += increment;
	if (levels[level_name] > MAX_LEVEL):
		levels[level_name] = MAX_LEVEL;
		return -1; 
	return levels[level_name];
	
func _ready() -> void:
	chara = $player/CollisionShape3D
	$player.remove_child(chara)
	add_child(chara)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = MAX_JUMP_VELOCITY * (ACCEL/100.0)
		if (velocity.y < INITIAL_JUMP_VELOCITY):
			velocity.y = INITIAL_JUMP_VELOCITY
	
	if Input.is_action_just_pressed("raise_arm"):
		$player_default/AnimationPlayer.play("left_arm_movement")
	
	if (Input.is_action_just_pressed("focus_mouse") and !Global.in_menu):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		game_focus = true
	if (Input.is_action_just_pressed("show_mouse")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		game_focus = false
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * ACCEL
		velocity.z = direction.z * ACCEL
	else:
		velocity.x = move_toward(velocity.x, 0, 2 + 10*(CONTROL-1)) # this is fixed rather than relative to ACCEL, if ACCEL initial value or max value changes, this whould also change
		velocity.z = move_toward(velocity.z, 0, 2 + 10*(CONTROL-1))

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and game_focus:
		rotate(Vector3(0, 1, 0), deg_to_rad(-event.relative.x * mouse_horizontal_sens))
		current_vert_view += -event.relative.y * mouse_vertical_sens
		current_vert_view = clamp(current_vert_view, -DEGREE_OF_VERTICAL_VIEW, DEGREE_OF_VERTICAL_VIEW)
		$Player_cam.rotation.x = deg_to_rad(current_vert_view)

func get_level(stat: int) -> int:
	if (stat == 0):
		return levels["dmg"]
	elif (stat == 1):
		return levels["accel"]
	elif (stat ==2):
		return levels["def"]
	elif (stat == 3):
		return levels["ctrl"]
	elif (stat == 4):
		return levels["atkspd"]
	elif (stat==5):
		return levels["crit"]
	return 1
	
func add_level(stat: int, amount: int) -> bool:
	if (stat == 0):
		levels["dmg"] += amount
		if (levels["dmg"] > 10):
			levels["dmg"] = 10
			return false
	elif (stat == 1):
		levels["accel"] += amount
		if (levels["accel"] > 10):
			levels["accel"] = 10
			return false
	elif (stat ==2):
		levels["def"] += amount
		if (levels["def"] > 10):
			levels["def"] = 10
			return false
	elif (stat == 3):
		levels["ctrl"] += amount
		if (levels["ctrl"] > 10):
			levels["ctrl"] = 10
			return false
	elif (stat == 4):
		levels["atkspd"] += amount
		if (levels["atkspd"] > 10):
			levels["atkspd"] = 10
			return false
	elif (stat==5):
		levels["crit"] += amount
		if (levels["crit"] > 10):
			levels["crit"] = 10
			return false
	update_stats();
	return true
	
func update_stats():
	ATK_SPEED = levels["atkspd"] * 10;
	DAMAGE = levels["dmg"] * 10;
	CRITICAL = levels["crit"];
	CONTROL = levels["ctrl"];
	DEFENSE = levels["def"] * 5;
	ACCEL = levels["accel"] * 10;
	max_sens = CONTROL * 0.1
