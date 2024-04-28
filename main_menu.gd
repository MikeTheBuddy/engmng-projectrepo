extends Control

enum Mode {Standard,Questionnaire}

const MAIN_ROOM = preload("res://main_room.tscn")

@onready var mode_select = $MenuOptions/ModeSelect
@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("TitleBob")

func _on_play_pressed():
	var scene = PackedScene.new()
	var game = MAIN_ROOM.instantiate()
	match mode_select.text:
		"Standard":
			game.mode = Mode.Standard
		"Questionnaire":
			game.mode = Mode.Questionnaire
	
	scene.pack(game)
	
	get_tree().change_scene_to_packed(scene)


func _on_quit_pressed():
	get_tree().quit()
