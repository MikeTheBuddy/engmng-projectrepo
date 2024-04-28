extends Node2D

@onready var tile_map = $TileMap
@onready var gui = $GUILayer/GUI
@onready var transition = $GUILayer/Transition

@onready var game_over = $GUILayer/GameOver

@onready var see_button = $GUILayer/SeeButton
@onready var hide_button = $GUILayer/HideButton
@onready var quit_button = $GUILayer/QuitButton
@onready var remaining_time = $GUILayer/RemainingTime

var change_index = 0

var answer_submitted = false

const PROP_LAYER = 2

const SOURCE_ID = 0

const CHANGE_INDEX_LIMIT = 5

enum Mode {Standard,Questionnaire}

@onready var search_timer = $SearchTimer

@export var mode: Mode

func _ready():
	if mode == Mode.Standard:
		gui.visible = false
	else:
		gui.visible = true
		
	transition.get_node("AnimationPlayer").play("fade_in")
	await transition.get_node("AnimationPlayer").animation_finished
	
	gui.submitted_answer.connect(submitted)

	search_timer.start()
	
func _process(_delta):
	if Input.is_action_just_pressed("DebugButton"):
		#change_room_fademode()
		match change_index:
			0: # CHANGE ONE
				tile_map.set_cell(PROP_LAYER,Vector2i(14,3),SOURCE_ID,Vector2i(13,3))
			1: # CHANGE TWO
				tile_map.set_cell(PROP_LAYER,Vector2i(-17,-6),-1,Vector2i(-1,-1))
			2: # CHANGE THREE
				tile_map.set_cell(PROP_LAYER,Vector2i(-16,1),SOURCE_ID,Vector2i(14,3))
			3: # CHANGE FOUR
				tile_map.set_cell(PROP_LAYER,Vector2i(-12,4),SOURCE_ID,Vector2i(19,0))
			4: # CHANGE FIVE
				tile_map.set_cell(PROP_LAYER,Vector2i(-7,1),SOURCE_ID,Vector2i(14,2))
			5: # CHANGE SIX
				tile_map.set_cell(PROP_LAYER,Vector2i(-5,2),SOURCE_ID,Vector2i(22,0))
		change_index += 1

func submitted():
	answer_submitted = true

func change_room():
	match change_index:
		0: # CHANGE ONE
			tile_map.set_cell(PROP_LAYER,Vector2i(14,3),SOURCE_ID,Vector2i(13,3))
		1: # CHANGE TWO
			tile_map.set_cell(PROP_LAYER,Vector2i(-17,-6),-1,Vector2i(-1,-1))
		2: # CHANGE THREE
			tile_map.set_cell(PROP_LAYER,Vector2i(-16,1),SOURCE_ID,Vector2i(14,3))
		3: # CHANGE FOUR
			tile_map.set_cell(PROP_LAYER,Vector2i(-12,4),SOURCE_ID,Vector2i(19,0))
		4: # CHANGE FIVE
			tile_map.set_cell(PROP_LAYER,Vector2i(-7,1),SOURCE_ID,Vector2i(14,2))
		5: # CHANGE SIX
			tile_map.set_cell(PROP_LAYER,Vector2i(-5,2),SOURCE_ID,Vector2i(22,0))
	change_index += 1
		
func change_room_fademode():
	transition.get_node("AnimationPlayer").play("fade_out")
	await transition.get_node("AnimationPlayer").animation_finished
	
	match change_index:
			0: # CHANGE ONE
				tile_map.set_cell(PROP_LAYER,Vector2i(14,3),SOURCE_ID,Vector2i(13,3))
			1: # CHANGE TWO
				tile_map.set_cell(PROP_LAYER,Vector2i(-17,-6),-1,Vector2i(-1,-1))
			2:
				tile_map.set_cell(PROP_LAYER,Vector2i(-16,1),SOURCE_ID,Vector2i(14,3))
			3:
				tile_map.set_cell(PROP_LAYER,Vector2i(-12,4),SOURCE_ID,Vector2i(19,0))
			4:
				tile_map.set_cell(PROP_LAYER,Vector2i(-7,1),SOURCE_ID,Vector2i(14,2))
			5:
				tile_map.set_cell(PROP_LAYER,Vector2i(-5,2),SOURCE_ID,Vector2i(22,0))
	change_index += 1
	
	transition.get_node("AnimationPlayer").play("fade_in")
	await transition.get_node("AnimationPlayer").animation_finished
	
	search_timer.start()

func _on_search_timer_timeout():
	if mode == Mode.Standard:
		if change_index <= CHANGE_INDEX_LIMIT:
			change_room_fademode()
		else:
			transition.get_node("AnimationPlayer").play("fade_out")
			await transition.get_node("AnimationPlayer").animation_finished
			remaining_time.visible = false
			game_over.visible = true
			see_button.visible = true
			quit_button.visible = true
	else: # questionnare mode
		#print("HERE")
		if change_index <= CHANGE_INDEX_LIMIT:
			await gui.call("force_open")
			
			if answer_submitted == false:
				await gui.submitted_answer
			change_room()
			gui.call("next_question")
			gui.get_node("Open").disabled = false
			gui.get_node("Close").disabled = false
			answer_submitted = false
			search_timer.start()
		else:
			await gui.call("force_open")
			
			if answer_submitted == false:
				await gui.submitted_answer
				
			
			transition.get_node("AnimationPlayer").play("fade_out")
			await transition.get_node("AnimationPlayer").animation_finished
			gui.visible = false
			remaining_time.visible = false
			game_over.visible = true
			see_button.visible = true
			quit_button.visible = true

func _on_button_pressed():
	$TileMapRevealed.visible = true
	game_over.visible = false
	see_button.visible = false
	quit_button.visible = false
	tile_map.set_modulate(Color(1,1,1,0.4))
	transition.get_node("AnimationPlayer").play("fade_in")
	await transition.get_node("AnimationPlayer").animation_finished
	hide_button.visible = true

func _on_hide_button_pressed():
	hide_button.visible = false
	transition.get_node("AnimationPlayer").play("fade_out")
	await transition.get_node("AnimationPlayer").animation_finished
	game_over.visible = true
	see_button.visible = true
	quit_button.visible = true

func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
