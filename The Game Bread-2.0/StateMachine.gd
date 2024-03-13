extends Node
class_name StateMachine

@export var state_machine_name: String
@export var default_state: State

var current_state: State
var states_dictionary: Dictionary = {}



# Called when the node enters the scene tree for the first time.
func _ready():
	get_states()
	current_state = default_state

func get_states():
	for child in get_children():
		if child is State:
			State[child.name.to_lower()] = child
	pass

func queue_state():
	pass

func switch_states(state:State, new_state_name):
	if state != current_state:
		print("WARNING: Change of state called by not active State.")
	
	var new_state = states_dictionary.get(new_state_name.to_lower())
	assert(new_state, "WARNING: No State")
	
	if current_state != new_state and new_state.available:
		current_state.exit()
		current_state = new_state
		current_state.enter()
	



