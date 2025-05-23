extends GameState

@onready var setup_ui: CanvasLayer = $"../../../SetupUI"
@onready var background_grid: TileMapLayer = $"../../../BackgroundGrid"


func enter() -> void:
	background_grid.show()
	setup_ui.show()
	var track_cards = get_tree().get_nodes_in_group("track_cards")
	for c in track_cards:
		c.drag_and_drop.enabled = true


func exit() -> void:
	setup_ui.hide_shop_ui()
	setup_ui.hide()
	var track_cards = get_tree().get_nodes_in_group("track_cards")
	for c in track_cards:
		c.drag_and_drop.enabled = false
