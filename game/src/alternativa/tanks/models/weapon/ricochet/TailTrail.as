package alternativa.tanks.models.weapon.ricochet {
  import alternativa.tanks.sfx.SimplePlane;

  internal class TailTrail extends SimplePlane {
    public function TailTrail(param1:Number, param2:Number) {
      super(param1,param2,0.5,1);
      setUVs(1,1,1,0,0,0,0,1);
      shadowMapAlphaThreshold = 2;
      depthMapAlphaThreshold = 2;
      useShadowMap = false;
      useLight = false;
    }
  }
}
