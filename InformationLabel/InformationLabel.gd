tool
extends Spatial

export(String) var title
export(String) var type
export(String, MULTILINE) var desc
export(String) var year
export(bool) var add_comma := false

export(int) var year_offset

onready var title_label = $TextPivot/Title
onready var type_label = $TextPivot/Type
onready var desc_label = $TextPivot/Desc
onready var year_label = $TextPivot/Year

func _ready():
    title_label.text = title
    type_label.text = type
    desc_label.text = desc
    year_label.text = year
    
    year_label.offset.x = year_offset
    
    title_label.text += "," if add_comma else ""

func _process(delta):
    title_label.text = title
    type_label.text = type
    desc_label.text = desc
    year_label.text = year
    
    year_label.offset.x = year_offset
    
    title_label.text += "," if add_comma else ""
    
