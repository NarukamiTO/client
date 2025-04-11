package alternativa.tanks.sfx {
  import alternativa.engine3d.lights.OmniLight;
  import alternativa.tanks.utils.objectpool.Pool;

  public final class OmniStreamLightEffect extends StreamLightEffect {
    public function OmniStreamLightEffect(param1:Pool) {
      super(param1,new OmniLight(0,0,0));
    }

    public function init(param1:Object3DPositionProvider, param2:LightAnimation, param3:LightAnimation) : void {
      this.positionProvider = param1;
      this.startTime = param2.getLiveTime();
      this.loopTime = param3.getLiveTime();
      this.startAnimation = param2;
      this.loopAnimation = param3;
      this.random = loopTime / 4;
      starting = true;
      currentTime = 0;
      alive = true;
      fading = false;
      fadeTime = 0;
    }
  }
}
