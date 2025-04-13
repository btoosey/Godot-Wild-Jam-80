class_name TrackCard
extends Area2D

@export var stats: TrackCardStats : set = set_stats

@onready var track_card_sprite: Sprite2D = $TrackCardSprite


func set_stats(value: TrackCardStats) -> void:
	stats = value

	if value == null:
		return

	if not is_node_ready():
		await ready

	track_card_sprite.region_rect.position = Vector2(stats.skin_coordinates) * Main.TRACK_CARD_SIZE
