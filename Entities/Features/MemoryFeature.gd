extends Node

#variables
var param_array = []


func _ready():
	#connect signals
	GSM.connect("init_params", self, "init_params")
	GSM.connect("save_params", self, "save_params")
	GSM.connect("load_params", self, "load_params")
	GSM.connect("level_run_complete", self, "level_run_complete")
	
	#initialize recording
	if get_parent().has_method("set_recording"):
		get_parent().recording = true


func init_params(param_count):
	if param_array == []:
		for i in range(param_count):
			param_array.append(null)


func save_params(index):
	if get_parent().has_method("save_params") and get_parent().has_method("get_recording") and get_parent().recording and index < param_array.size():
		var params = get_parent().save_params()
		param_array[index] = params


func load_params(index):
	if get_parent().has_method("load_params") and get_parent().has_method("get_recording") and not get_parent().recording and index < param_array.size():
		if param_array[index] != null:
			get_parent().load_params(param_array[index])


func level_run_complete(run_id):
	if get_parent().has_method("get_id") and get_parent().id == run_id and get_parent().has_method("set_recording"):
		get_parent().recording = false
