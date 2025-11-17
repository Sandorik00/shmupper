extends CanvasLayer

@onready var HealthBar: ProgressBar = $"./PanelAnchor/StatusPanel/PlayerHealth"

func _ready():
	HealthBar.value = PlayerContext.get_hp()
	PlayerContext.hp_change.connect(_player_hp_changed)

func _player_hp_changed(hp: int):
	HealthBar.value = hp

	if hp <= 0:
		%DeathScreen.visible = true
