package alternativa.tanks.models.weapon.machinegun.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class MachineGunHitEffect extends PooledObject implements GraphicEffect {
    private static const DUST_SIZE:Number = 90;
    private static const DUST_SPEED:Number = 200;
    private static const DUST_TOP:Number = 60;
    private static const DUST_INTERVAL:Number = 0.15;
    private static const LIFE_TIME:Number = 0.25;
    private static const EFFECT_POSITION_OBJECT:Object3D = new Object3D();
    private static const EFFECT_POSITION:Vector3 = new Vector3();

    private var dust:Smoke = new Smoke(DUST_SIZE,DUST_SPEED,DUST_TOP,DUST_INTERVAL);
    private var crumbs:Crumbs = new Crumbs();
    private var positionProvider:StaticObject3DPositionProvider;
    private var time:Number;

    public function MachineGunHitEffect(param1:Pool) {
      super(param1);
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.crumbs.setContainer(param1);
      this.crumbs.start();
      this.dust.setContainer(param1);
      this.dust.start();
    }

    public function init(param1:StaticObject3DPositionProvider, param2:MachineGunSFXData) : void {
      this.positionProvider = param1;
      param1.initPosition(EFFECT_POSITION_OBJECT);
      this.dust.setAnimation(param2.dustTexture);
      this.crumbs.setMaterial(param2.crumbsTexture);
      this.time = 0;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      this.positionProvider.updateObjectPosition(EFFECT_POSITION_OBJECT,param2,param1);
      this.updateEmitterPosition();
      var local3:Number = param1 / 1000;
      this.time += local3;
      if(this.time >= LIFE_TIME) {
        this.dust.stop();
        this.crumbs.stop();
      }
      var local4:Boolean = this.dust.update(local3);
      return this.crumbs.update(local3) || local4;
    }

    private function updateEmitterPosition() : void {
      EFFECT_POSITION.x = EFFECT_POSITION_OBJECT.x;
      EFFECT_POSITION.y = EFFECT_POSITION_OBJECT.y;
      EFFECT_POSITION.z = EFFECT_POSITION_OBJECT.z;
      this.dust.setEmitterPosition(EFFECT_POSITION);
      this.crumbs.setEmitterPosition(EFFECT_POSITION);
    }

    public function destroy() : void {
      this.dust.clear();
      this.crumbs.clear();
      this.positionProvider.destroy();
      this.positionProvider = null;
      recycle();
    }

    public function kill() : void {
      this.dust.stop();
      this.crumbs.stop();
    }
  }
}
