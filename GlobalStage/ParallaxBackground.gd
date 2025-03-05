extends ParallaxBackground

@export var speed := 200

func _process(delta):
	scroll_offset.y += speed * delta
	#print(scroll_offset)
