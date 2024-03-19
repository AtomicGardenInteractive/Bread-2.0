extends Node
class_name StateMachine

@export var state_machine_name: StringName
@export var default_state: State

var current_state: State
var states_dictionary: Dictionary = {}
var states_queue : Array
var queue_empty : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	get_states()
	current_state = default_state
	

func get_states():
	for child in get_children():
		if child is State:
			State[child.name.to_lower()] = child
			child.ChangeState.connect(on_active_state_change_called)

func on_active_state_change_called(target_state_machine_name:StringName, state:State, new_state_name:StringName, add_to_queue:bool):
	if target_state_machine_name == state_machine_name:
		if state != current_state:
			print("WARNING: Change of state called by not active State.")
		
		if add_to_queue:
			queue_state(state, new_state_name)
		
		else:
			switch_states(state, new_state_name)

func queue_state(state:State, new_state_name:StringName):
	states_queue.append(new_state_name.to_lower())
	queue_empty = false
	pass

func empty_queue():
	states_queue.clear()
	queue_empty = true
	pass

func switch_states(state:State, new_state_name:StringName):
	var new_state = states_dictionary.get(new_state_name.to_lower())
	assert(new_state, "WARNING: No State")
	
	if current_state != new_state and new_state.available:
		current_state.exit()
		current_state = new_state
		current_state.enter()
	



