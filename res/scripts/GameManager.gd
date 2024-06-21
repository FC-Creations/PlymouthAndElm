extends Node

@onready var plymouth = $"../Plymouth"
@onready var elm = $"../Elm"
@onready var player_camera = $"../PlayerCamera"

func _ready():
	plymouth.is_active = true

func _process(_delta):
	if Input.is_action_just_pressed("switch"):
		if plymouth.is_active:
			elm.is_active = true
			plymouth.is_active = false
			player_camera.focus_on = elm
		else:
			plymouth.is_active = true
			elm.is_active = false
			player_camera.focus_on = plymouth
