class_name Main
extends Node2D

const CELL_SIZE := Vector2(64, 64)
const TRACK_CARD_SIZE := Vector2(64, 128)
const HALF_TRACK_CARD_SIZE := Vector2(32, 64)
const CPU_SPRITE_SIZE := Vector2(14, 14)

@export var main_music_theme: AudioStream

@onready var game_state_machine: GameStateMachine = $"Components/GameStateMachine" as GameStateMachine
@onready var track_card_mover: TrackCardMover = $Components/TrackCardMover
@onready var track_card_spawner: TrackCardSpawner = $Components/TrackCardSpawner
@onready var circuit_manager: CircuitManager = $Components/CircuitManager


func _ready() -> void:
	track_card_spawner.track_card_spawned.connect(track_card_mover.setup_track_card)
	track_card_spawner.track_card_spawned.connect(circuit_manager.setup_track_card)
	game_state_machine.init()

	MusicPlayer.play(main_music_theme)
