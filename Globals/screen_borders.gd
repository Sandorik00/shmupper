extends Node

var game_field := Rect2()

func set_screen_size(_screen_size: Dictionary):
	game_field = Rect2(_screen_size.min, _screen_size.max - _screen_size.min)
