package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.lights.SpotLight;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;

  public final class SpotStreamLightEffect extends StreamLightEffect {
    private var targetPositionProvider:Object3DPositionProvider;
    private var targetObject:Object3D;

    public function SpotStreamLightEffect(param1:Pool) {
      super(param1,new SpotLight(0,0,0,Math.PI / 3,Math.PI / 2));
      this.targetObject = new Object3D();
    }

    public function init(param1:Object3DPositionProvider, param2:Object3DPositionProvider, param3:LightAnimation, param4:LightAnimation) : void {
      this.positionProvider = param1;
      this.targetPositionProvider = param2;
      this.startTime = param3.getLiveTime();
      this.loopTime = param4.getLiveTime();
      this.startAnimation = param3;
      this.loopAnimation = param4;
      this.random = loopTime / 4;
      starting = true;
      currentTime = 0;
      alive = true;
      fading = false;
      fadeTime = 0;
    }

    override public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Boolean = super.play(param1,param2);
      this.targetPositionProvider.updateObjectPosition(this.targetObject,param2,param1);
      var local4:SpotLight = SpotLight(light);
      local4.lookAt(this.targetObject.x,this.targetObject.y,this.targetObject.z);
      return local3;
    }

    override public function addedToScene(param1:Scene3DContainer) : void {
      super.addedToScene(param1);
      param1.addChild(this.targetObject);
    }

    override public function destroy() : void {
      container.removeChild(this.targetObject);
      this.targetPositionProvider.destroy();
      this.targetPositionProvider = null;
      super.destroy();
    }
  }
}
