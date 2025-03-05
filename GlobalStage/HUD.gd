extends CanvasLayer

@onready var HealthBar: ProgressBar = $"./PanelAnchor/StatusPanel/PlayerHealth"

var HP = 3

func _ready():
	HealthBar.value = 3

func take_damage(amount: int, player: Node2D):
	HP -= amount
	HealthBar.value = HP

	if HP <= 0:
		player.queue_free()
		%DeathScreen.visible = true