extends CanvasLayer

@onready var game_state_machine: GameStateMachine = $"../Components/GameStateMachine" as GameStateMachine
@onready var player_path: Path2D = $"../Components/RaceManager/RacerPaths/PlayerPath"

@onready var panel: Panel = $Panel
@onready var money: Label = $Panel/ShopUI/Money
@onready var top_speed: Button = $Panel/ShopUI/CarUpgradesUI/TopSpeed
@onready var accelerator_power: Button = $Panel/ShopUI/CarUpgradesUI/AcceleratorPower
@onready var brake_power: Button = $Panel/ShopUI/CarUpgradesUI/BrakePower

var displayed := false


func _ready() -> void:
	top_speed.text = str("Increase\nTop Speed\n", top_speed.price, "$")
	accelerator_power.text = str("Increase\nAcceleration\n", accelerator_power.price, "$")
	brake_power.text = str("Increase\nBrake Power\n", brake_power.price, "$")


func _process(_delta: float) -> void:
	money.text = str(PlayerStatsGlobal.money, "$")

	if PlayerStatsGlobal.money < top_speed.price:
		top_speed.disabled = true
	else:
		top_speed.disabled = false

	if PlayerStatsGlobal.money < accelerator_power.price:
		accelerator_power.disabled = true
	else:
		accelerator_power.disabled = false

	if PlayerStatsGlobal.money < brake_power.price:
		brake_power.disabled = true
	else:
		brake_power.disabled = false


func _on_start_race_button_pressed() -> void:
	game_state_machine._on_transition_requested(game_state_machine.current_state, GameState.State.RACE)


func _on_top_speed_pressed() -> void:
	player_path.top_speed += 0.02
	PlayerStatsGlobal.money -= top_speed.price


func _on_accelerator_power_pressed() -> void:
	player_path.acceleration += 0.01
	PlayerStatsGlobal.money -= accelerator_power.price


func _on_brake_power_pressed() -> void:
	player_path.deceleration += 0.01
	PlayerStatsGlobal.money -= brake_power.price

func _on_shop_pressed() -> void:
	if displayed:
		hide_shop_ui()
	else:
		show_shop_ui()


func hide_shop_ui() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(panel, "position", Vector2(-994, 590), 0.4)
	displayed = false


func show_shop_ui() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(panel, "position", Vector2(0, 590), 0.4)
	displayed = true
