extends KinematicBody2D

#variables
var velocity = Vector2.ZERO
export var h_accel = 0
export var h_decel = 0
export var jump = 0
export var gravity = 0
export var h_max = 0
export var v_max = 0

var recording = true setget set_recording, get_recording
var id = 0 setget set_id,get_id


func _physics_process(delta):
	if recording:
		set_coyote_timer()
		get_input()
		move_and_slide(velocity * Vector2(delta * 1000, delta * 1000), Vector2.UP)


func set_coyote_timer():
	if is_on_floor():
		$CoyoteTimer.start()
		velocity.y = 0


func get_input():
	#horizontal inputs
	if Input.is_action_pressed("ui_left"):
		velocity.x = clamp(velocity.x - h_accel, -h_max, h_max)
	elif Input.is_action_pressed("ui_right"):
		velocity.x = clamp(velocity.x + h_accel, -h_max, h_max)
	elif velocity.x > h_decel:
		velocity.x = clamp(velocity.x - h_decel, -h_max, h_max)
	elif velocity.x < -h_decel:
		velocity.x = clamp(velocity.x + h_decel, -h_max, h_max)
	else:
		velocity.x = 0
	
	#vertical inputs - after applying gravity
	velocity.y = clamp(velocity.y + gravity, -v_max, v_max)
	if Input.is_action_pressed("ui_up") and not $CoyoteTimer.is_stopped():
		velocity.y = clamp(velocity.y - jump, -v_max, v_max)
		if not $CoyoteTimer.is_stopped():
			$CoyoteTimer.stop()


func _on_CoyoteTimer_timeout():
	$CoyoteTimer.stop()


func save_params():
	var params = {
		"global_position" : global_position
	}
	return params


func load_params(params):
	global_position = params["global_position"]


func set_recording(new_val):
	recording = new_val


func get_recording():
	return recording


func set_id(new_val):
	id = new_val


func get_id():
	return id

















