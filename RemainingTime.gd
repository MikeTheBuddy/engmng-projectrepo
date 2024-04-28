extends ProgressBar

@onready var search_timer = $"../../SearchTimer"

func _process(_delta):
	value = int(search_timer.get_time_left())*5
