extends Label

func _process(_delta):
	self.text = "FPS:%s" % int(Engine.get_frames_per_second())