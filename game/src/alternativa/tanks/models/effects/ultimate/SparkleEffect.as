package alternativa.tanks.models.effects.ultimate {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import flash.display.BlendMode;

  public class SparkleEffect extends Sprite3D {
    public function SparkleEffect() {
      super(512,512);
    }

    public function init(param1:TextureMaterial) : * {
      material = param1;
      calculateBounds();
      blendMode = BlendMode.ADD;
      softAttenuation = 100;
    }
  }
}
