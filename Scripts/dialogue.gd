extends CanvasLayer

var speaker
var nameText:=""
var bodyText:=""

func _ready() -> void:
	visible=false

func loadDialogue():
	visible=true
	$Nameplate/Name.text=nameText
	$Text.text=bodyText
	$Text.visible_characters=0
	while $Text.visible_ratio<1:
		await get_tree().process_frame
		$Text.visible_characters+=1
		if(Input.is_action_just_pressed("Interact")):
			$Text.visible_ratio=1
	await get_tree().process_frame
	while not Input.is_action_just_pressed("Interact"):
		await get_tree().process_frame
	speaker.nextText()
