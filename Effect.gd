extends Node
class_name Effect

var affects_sell_value: bool = false
var affects_activate_cost: bool = false

var sell_value_multiplier: float = 1.0
var sell_value_increase: int = 0

var activate_cost_multiplier: float = 1.0
var activate_cost_decrease: int = 0

var is_card_eligible: Callable = func(_a: Card) -> bool: return false

var tooltip: String = ''

var cost: int = 0

var weight: int = 1

func _init(
	init_affects_sell_value: bool = false,
	init_affects_activate_cost: bool = false,
	init_sell_value_multiplier: float = 1.0,
	init_sell_value_increase: int = 0,
	init_activate_cost_multiplier: float = 1.0,
	init_activate_cost_decrease: int = 0,
	init_is_card_eligible: Callable = func(_a: Card) -> bool: return false,
	init_tooltip: String = '',
	init_cost: int = 0,
) -> void:
	affects_sell_value = init_affects_sell_value
	affects_activate_cost = init_affects_activate_cost
	sell_value_multiplier = init_sell_value_multiplier
	sell_value_increase = init_sell_value_increase
	activate_cost_multiplier = init_activate_cost_multiplier
	activate_cost_decrease = init_activate_cost_decrease
	is_card_eligible = init_is_card_eligible
	tooltip = init_tooltip
	cost = init_cost

static func get_effect_list() -> Array[Effect]:
	var list: Array[Effect]

	# var odd_numbers_give_double: Effect = Effect.new()
	# odd_numbers_give_double.affects_sell_value = true
	# odd_numbers_give_double.sell_value_multiplier = 2.0
	# odd_numbers_give_double.is_card_eligible = func(card: Card) -> bool:
	# 	return card.face_value % 2 == 1
	# odd_numbers_give_double.tooltip = "Odd numbered cards will sell for double their original price"
	var odd_numbers_give_double := Effect.new(
		true, false,
		2.0, 0,
		1.0, 0,
		func(card: Card) -> bool:
			return card.face_value % 2 == 1,
		"Odd numbered cards will sell for double their original price",
		550,
	)

	list.append(odd_numbers_give_double)
	
	var even_numbers_give_double := Effect.new(
		true, false,
		2.0, 0,
		1.0, 0,
		func(card: Card) -> bool:
			return card.face_value % 2 == 0,
		"Even numbered cards will sell for double their original price",
		550,
	)

	list.append(even_numbers_give_double)

	return list

