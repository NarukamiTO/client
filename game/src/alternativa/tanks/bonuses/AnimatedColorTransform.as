package alternativa.tanks.bonuses {
  import alternativa.tanks.animations.AnimatedValue;
  import flash.geom.ColorTransform;

  public class AnimatedColorTransform implements AnimatedValue {
    public const colorTransform:ColorTransform = new ColorTransform();

    public function AnimatedColorTransform() {
      super();
    }

    public function setAnimatedValue(param1:Number) : void {
      this.colorTransform.redOffset = param1;
      this.colorTransform.greenOffset = param1;
      this.colorTransform.blueOffset = param1;
    }
  }
}
