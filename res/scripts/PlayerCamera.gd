extends Camera2D
@onready var focus_on = get_node("../Plymouth")

func _process(_delta):
	position = focus_on.position
