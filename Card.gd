@tool
class_name Card
extends Node2D

@onready var value_label: Label = %ValueLabel
@onready var suit_label: Label = %SuitLabel

@onready var sell_value_label: Label = %SellValueLabel

@onready var ability_desc_label: Label = %AbilityDescLabel
@onready var ability_cost_label: Label = %AbilityCostLabel


enum CardValue {
	ZERO,
	ONE,
	TWO,
	THREE,
	FOUR,
	FIVE,
	SIX,
	SEVEN,
	EIGHT,
	NINE,
	TEN,
	JACK,
	QUEEN,
	KING,
	ACE,
}

func get_card_value_string(value: CardValue) -> String:
	if value <= CardValue.TEN:
		return str(value)

	if value == CardValue.JACK:
		return 'J'
	if value == CardValue.QUEEN:
		return 'Q'
	if value == CardValue.KING:
		return 'K'
	if value == CardValue.ACE:
		return 'A'
	
	return ''

enum CardSuit {
	SPADES,
	HEARTS,
	CLUBS,
	DIAMONDS,
}

func get_card_suit_string(value: CardSuit) -> String:
	match value:
		CardSuit.SPADES:
			return '♠'
		CardSuit.HEARTS:
			return '♥'
		CardSuit.CLUBS:
			return '♣'
		CardSuit.DIAMONDS:
			return '♦'
			
		_:
			return ''
		

@export
var face_value: CardValue = CardValue.ZERO:
	set(new_value):
		if value_label != null:
			value_label.text = get_card_value_string(new_value)
		face_value = new_value
		update_sell_value_label()


var BLACK_ICON_COLOR: Color = Color("2e2e2e")
var RED_ICON_COLOR: Color = Color("e03434")

@export
var suit: CardSuit = CardSuit.SPADES:
	set(new_value):
		if suit_label != null:
			suit_label.text = get_card_suit_string(new_value)

			if new_value == CardSuit.HEARTS || new_value == CardSuit.DIAMONDS:
				suit_label.add_theme_color_override("font_color", RED_ICON_COLOR)
			else:
				suit_label.add_theme_color_override("font_color", BLACK_ICON_COLOR)

			 
		suit = new_value

var effect: Effect

func _ready() -> void:
	suit = suit
	face_value = face_value

	sell_value = get_sell_value(face_value)
	update_sell_value_label()

var sell_value: int

func get_sell_value(value: CardValue = face_value) -> int:
	if value <= CardValue.TEN:
		return value * 10
	
	if value == CardValue.JACK:
		return 150
	if value == CardValue.QUEEN:
		return 200
	if value == CardValue.KING:
		return 300
	if value == CardValue.ACE:
		return 500
	
	return 0

func update_sell_value_label() -> void:
	if sell_value_label != null:
		sell_value_label.text = str(sell_value)


func set_values(new_face_value: CardValue, new_suit: CardSuit, new_effect: Effect) -> void:
	face_value = new_face_value
	suit = new_suit

	sell_value = get_sell_value()

	effect = new_effect

	if ability_desc_label != null:
		ability_desc_label.text = effect.tooltip
		ability_cost_label.text = str(effect.cost)



func get_activate_cost() -> int:
	return effect.cost
