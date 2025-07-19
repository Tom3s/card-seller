class_name GameScene
extends Node2D

@onready var main_card: Card = %Card

@onready var score_label: Label = %ScoreLabel

@onready var activate_button: Button = %ActivateButton
@onready var sell_button: Button = %SellButton

# base chances, all of them have the same chance to generate
var value_chances: Array[int] = [
	1, #ZERO,
	1, #ONE,
	1, #TWO,
	1, #THREE,
	1, #FOUR,
	1, #FIVE,
	1, #SIX,
	1, #SEVEN,
	1, #EIGHT,
	1, #NINE,
	1, #TEN,
	1, #JACK,
	1, #QUEEN,
	1, #KING,
	1, #ACE,
]

var suit_chances: Array[int] = [
	1, #SPADES,
	1, #HEARTS,
	1, #CLUBS,
	1, #DIAMONDS,
]

var score: int = 0

func get_weighted_random_value(chances: Array[int]) -> int:
	var total: int = 0
	for num in chances:
		total += num

	# r = random.uniform(0, total)
	var r := randi_range(0, total - 1)
	var cumulative := 0
	var index := 0
	# for i, w in enumerate(chances):
	for num in chances:
		cumulative += num
		if r < cumulative:
			return index
		index += 1
	
	return 0

func generate_new_card() -> void:
	var value: Card.CardValue = get_weighted_random_value(value_chances) as Card.CardValue
	var suit: Card.CardSuit = get_weighted_random_value(suit_chances) as Card.CardSuit

	main_card.set_values(value, suit)



func _ready() -> void:
	score_label.text = str(score)

	sell_button.pressed.connect(on_sell)
	activate_button.pressed.connect(on_activate)

	generate_new_card()

func on_sell() -> void:
	score += main_card.get_sell_value()

	score_label.text = str(score)

	generate_new_card()

func on_activate() -> void:
	score -= main_card.get_activate_cost()

	score_label.text = str(score)

	generate_new_card()
