tool
extends Spatial

class_name ArtFrame

export(Material) var material
export(Vector2) var canvas_size = Vector2(1, 1)

func _process(delta):
    $ArtCanvas.set_surface_material(0, self.material)
    $ArtCanvas.mesh.size = canvas_size
