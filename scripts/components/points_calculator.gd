extends Node

@export var race_manager: RaceManager
var prize_order = []

func calculate_prize_money() -> void:
	var prize_money := 5
	for racer in race_manager.race_order:
		print(racer)
		if racer == $"../RaceManager/RacerPaths/PlayerPath/PathFollow2D/Player":
			PlayerStatsGlobal.money += prize_money
		prize_order.append(prize_money)
		prize_money -= 1
