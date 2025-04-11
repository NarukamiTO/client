package alternativa.tanks.sfx {
  import alternativa.engine3d.lights.OmniLight;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class FadingLightEffect extends PooledObject implements GraphicEffect {
    public static const DEFAULT_CURVE:Number = 1 / 2.2;

    private var light:OmniLight;
    private var time:int;
    private var currentTime:int;
    private var curve:Number;
    private var container:Scene3DContainer;
    private var sourceIntensity:Number;

    public function FadingLightEffect(param1:Pool) {
      super(param1);
      this.light = new OmniLight(0,0,0);
    }

    public function init(param1:OmniLight, param2:int, param3:Number = 0.45454545454545453) : void {
      this.light.intensity = param1.intensity;
      this.light.color = param1.color;
      this.light.attenuationBegin = param1.attenuationBegin;
      this.light.attenuationEnd = param1.attenuationEnd;
      this.light.x = param1.x;
      this.light.y = param1.y;
      this.light.z = param1.z;
      this.light.calculateBounds();
      this.time = param2;
      this.curve = param3;
      this.sourceIntensity = param1.intensity;
      this.currentTime = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.light);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      this.currentTime += param1;
      this.currentTime = Math.min(this.currentTime,this.time);
      var local3:Number = 1 - this.currentTime / this.time;
      this.light.intensity = this.sourceIntensity * Math.pow(local3,this.curve);
      return this.currentTime < this.time;
    }

    public function destroy() : void {
      if(this.container != null) {
        this.container.removeChild(this.light);
        this.container = null;
      }
      recycle();
    }

    public function kill() : void {
      this.light = null;
    }
  }
}
