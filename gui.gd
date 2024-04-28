extends Control

@onready var answer_1_slider_label = $VBoxContainer/Answer1Box/Answer1SliderLabel
@onready var answer_2_slider_label = $VBoxContainer/Answer2Box/Answer2SliderLabel
@onready var answer_5_slider_label = $VBoxContainer/Answer5Box/Answer5SliderLabel
@onready var answer_6_slider_label = $VBoxContainer/Answer6Box/Answer6SliderLabel
@onready var answer_7_slider_label = $VBoxContainer/Answer7Box/Answer7SliderLabel



@onready var animation_player = $AnimationPlayer


@onready var open = $Open
@onready var close = $Close

const CLOSED_Y_VALUE = 400

signal menu_open
signal menu_closed

signal submitted_answer

var question_index = 0

func _ready():
	next_question()

func force_open():
	open.disabled = true
	close.disabled = true
	
	var tween = get_tree().create_tween()
	tween.tween_property($".","position",Vector2(0,0),0.5)
	await tween.finished
	

func _on_answer_1_slider_value_changed(value):
	answer_1_slider_label.text = str(value)


func _on_close_pressed():
	var tween = get_tree().create_tween()
	tween.tween_property($".","position",Vector2(0,get_viewport_rect().size.y),0.5)


func _on_open_pressed():
	var tween = get_tree().create_tween()
	tween.tween_property($".","position",Vector2(0,0),0.5)


func _on_answer_1_submit_button_pressed():
	$VBoxContainer/Answer1Box/Answer1SubmitButton.disabled = true
	$VBoxContainer/Answer1Box/Answer1Slider.editable = false
	submitted_answer.emit()

func _on_answer_2_slider_value_changed(value):
	answer_2_slider_label.text = str(value)


func _on_answer_2_submit_button_pressed():
	$VBoxContainer/Answer2Box/Answer2SubmitButton.disabled = true
	$VBoxContainer/Answer2Box/Answer2Slider.editable = false
	submitted_answer.emit()
	


func _on_answer_3_submit_button_pressed():
	$VBoxContainer/Answer3Box/Answer3SubmitButton.disabled = true
	$VBoxContainer/Answer3Box/TrueButton3.disabled = true
	$VBoxContainer/Answer3Box/FalseButton3.disabled = true
	submitted_answer.emit()
	


func _on_true_button_3_toggled(toggled_on):
	if toggled_on:
		$VBoxContainer/Answer3Box/FalseButton3.button_pressed = false


func _on_false_button_3_toggled(toggled_on):
	if toggled_on:
		$VBoxContainer/Answer3Box/TrueButton3.button_pressed = false



func _on_answer_4_submit_button_pressed():
	$VBoxContainer/Answer4Box/Answer4SubmitButton.disabled = true
	$VBoxContainer/Answer4Box/TrueButton4.disabled = true
	$VBoxContainer/Answer4Box/FalseButton4.disabled = true
	submitted_answer.emit()


func _on_true_button_4_toggled(toggled_on):
	if toggled_on:
		$VBoxContainer/Answer4Box/FalseButton4.button_pressed = false


func _on_false_button_4_toggled(toggled_on):
	if toggled_on:
		$VBoxContainer/Answer4Box/TrueButton4.button_pressed = false


func _on_answer_5_slider_value_changed(value):
	answer_5_slider_label.text = str(int((15*value)/60)) + ":" + str(int(15*value)%60)


func _on_answer_5_submit_button_pressed():
	$VBoxContainer/Answer5Box/Answer5SubmitButton.disabled = true
	$VBoxContainer/Answer5Box/Answer5Slider.editable = false
	submitted_answer.emit()

func next_question():
	match question_index:
		0:
			animation_player.play("question1_show")
		1:
			animation_player.play("question2_show")
		2:
			animation_player.play("question3_show")
		3:
			animation_player.play("question4_show")
		4:
			animation_player.play("question5_show")
		5:
			animation_player.play("question6_show")
		6:
			animation_player.play("question7_show")
	question_index += 1


func _on_question_6_slider_value_changed(value):
	answer_6_slider_label.text = str(value)


func _on_answer_6_submit_button_pressed():
	$VBoxContainer/Answer6Box/Answer6SubmitButton.disabled = true
	$VBoxContainer/Answer6Box/Answer6Slider.editable = false
	submitted_answer.emit()


func _on_answer_7_slider_value_changed(value):
	answer_7_slider_label.text = str(value)



func _on_answer_7_submit_button_pressed():
	$VBoxContainer/Answer7Box/Answer7SubmitButton.disabled = true
	$VBoxContainer/Answer7Box/Answer7Slider.editable = false
	submitted_answer.emit()
