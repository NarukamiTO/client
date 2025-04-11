package alternativa.tanks.models.tank.explosion {
  import alternativa.tanks.engine3d.TextureAnimation;

  public class ExplosionData {
    public var flameAnimation:TextureAnimation;
    public var shockWaveAnimation:TextureAnimation;
    public var smokeAnimation:TextureAnimation;

    public function ExplosionData(param1:TextureAnimation, param2:TextureAnimation, param3:TextureAnimation) {
      super();
      this.flameAnimation = param1;
      this.shockWaveAnimation = param2;
      this.smokeAnimation = param3;
    }
  }
}
