class_name InventoryTrackCardButton
extends TextureButton

@export var track_card_stats: TrackCardStats
@onready var price_label: Label = $PriceLabel

@onready var track_card_spawner: TrackCardSpawner = %TrackCardSpawner


func _ready() -> void:
	price_label.text = str(track_card_stats.price)
	texture_normal.region.position = Vector2(track_card_stats.skin_coordinates) * Main.HALF_TRACK_CARD_SIZE
	texture_disabled.region.position = Vector2(track_card_stats.skin_coordinates) * Main.HALF_TRACK_CARD_SIZE


func _on_pressed() -> void:
	track_card_spawner.spawn_track_card(track_card_stats)
