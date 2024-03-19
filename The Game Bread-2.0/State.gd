extends Node
class_name State

var state_machine: StateMachine
var available: bool = true
signal ChangeState

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = get_parent()
	pass # Replace with function body.

func enter():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_current():
		pass
	pass

#checks if is the current state in the statemachine and only processes if true.
func is_current():
	return state_machine.currentState == name.to_lower()
