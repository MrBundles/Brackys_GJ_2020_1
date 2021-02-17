extends TextureProgress

#variables
export var total_time = 0
export var save_count_per_sec = 0
var save_interval = 0
var save_count_total = 0
var save_count_current = 0

var init_param_msec = 0
var current_param_msec = 0
var elapsed_param_msec = 0

var run_id = 0
export var rewind_speed = 5
var rewinding = false


func _ready():
	init_param_msec = OS.get_ticks_msec()
	
	save_interval = 1000 / save_count_per_sec
	save_count_total = total_time / save_interval
	max_value = save_count_total
	
	GSM.emit_signal("spawn_player", run_id, save_count_total)


func _process(delta):
	value = save_count_current
	
	#param msecs
	current_param_msec = OS.get_ticks_msec()
	elapsed_param_msec = current_param_msec - init_param_msec
	
	if elapsed_param_msec > save_interval:
		init_param_msec = OS.get_ticks_msec()
		GSM.emit_signal("save_params", save_count_current)
		GSM.emit_signal("load_params", save_count_current)
		
		print(rewinding)
		
		if rewinding:
			save_count_current = clamp(save_count_current - rewind_speed, 0, save_count_total)
		else:
			save_count_current = clamp(save_count_current + 1, 0, save_count_total)
		
		if save_count_current == 0 and rewinding:
			rewinding = false
			GSM.emit_signal("spawn_player", run_id, save_count_total)
		
		if save_count_current >= save_count_total:
			GSM.emit_signal("level_run_complete", run_id)
			run_id += 1
			rewinding = true







