package alternativa.tanks.models.weapon.gauss.sfx {
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.weapon.BasicGlobalGunParams;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.ExternalObject3DPositionProvider;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;

  public class GaussMuzzleEffect extends PooledObject implements GraphicEffect {
    [Inject]
    public static var battleService:BattleService;

    private static var flame:GaussFlame;

    private static const FIRE_MIDDLE_TIME:Number = 6 / 60;
    private static const FIRE_END_TIME:Number = 11 / 60;
    private static const SMOKE_BEGIN_TIME:Number = 3 / 60;
    private static const SMOKE_END_TIME:Number = 25 / 60;
    private static const FLAME_END:Number = 7 / 60;
    private static const SMOKE1_AXIS_DISTANCE:Number = 150;
    private static const SMOKE1_SOLAR_DISTANCE:Number = 50;
    private static const SMOKE2_AXIS_DISTANCE:Number = 180;
    private static const SMOKE2_SOLAR_DISTANCE:Number = 70;
    private static const FIRE0_AXIS_DISTANCE_MIDDLE:Number = 200;
    private static const FIRE1_AXIS_DISTANCE_MIDDLE:Number = 100;
    private static const FIRE2_AXIS_DISTANCE_MIDDLE:Number = 50;
    private static const FIRE0_AXIS_DISTANCE_END:Number = 100;
    private static const FIRE1_AXIS_DISTANCE_END:Number = 100;
    private static const FIRE2_AXIS_DISTANCE_END:Number = 50;

    private var weaponPlatform:WeaponPlatform;
    private var lightEffectPositionProvider:ExternalObject3DPositionProvider;
    private var lightEffect:AnimatedLightEffect;
    private var time:Number;
    private var container:Scene3DContainer;
    private var flameView:Mesh;
    private var fire0:Sprite3D;
    private var fire1:Sprite3D;
    private var fire2:Sprite3D;
    private var smoke1:Sprite3D;
    private var smoke2:Sprite3D;
    private var gunParams:BasicGlobalGunParams = new BasicGlobalGunParams();
    private var vector:Vector3 = new Vector3();

    public function GaussMuzzleEffect(param1:Pool) {
      super(param1);
      this.fire0 = new Sprite3D(100,100);
      this.fire0.blendMode = BlendMode.ADD;
      this.fire0.rotation = Math.random() * Math.PI * 2;
      this.fire1 = new Sprite3D(100,100);
      this.fire1.blendMode = BlendMode.ADD;
      this.fire1.rotation = Math.random() * Math.PI * 2;
      this.fire2 = new Sprite3D(100,100);
      this.fire2.blendMode = BlendMode.ADD;
      this.fire2.rotation = Math.random() * Math.PI * 2;
      this.smoke1 = new Sprite3D(350,350);
      this.smoke1.rotation = Math.random() * Math.PI * 2;
      this.smoke2 = new Sprite3D(350,350);
      this.smoke2.rotation = Math.random() * Math.PI * 2;
    }

    public function init(param1:GaussSFXData, param2:WeaponPlatform) : void {
      this.weaponPlatform = param2;
      this.lightEffectPositionProvider = ExternalObject3DPositionProvider(battleService.getObjectPool().getObject(ExternalObject3DPositionProvider));
      this.lightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
      this.lightEffect.init(this.lightEffectPositionProvider,param1.primaryShellLightAnimation,AnimatedLightEffect.DEFAULT_MAX_DISTANCE,true);
      this.fire0.material = param1.fireTextureMaterial;
      this.fire1.material = param1.fireTextureMaterial;
      this.fire2.material = param1.fireTextureMaterial;
      this.smoke1.material = param1.smokeTextureMaterial;
      this.smoke2.material = param1.smokeTextureMaterial;
      if(flame == null) {
        flame = new GaussFlame(100,param1.flameTextureMaterial);
        flame.blendMode = BlendMode.ADD;
      }
      this.flameView = Mesh(flame.clone());
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.fire0);
      param1.addChild(this.fire1);
      param1.addChild(this.fire2);
      param1.addChild(this.smoke1);
      param1.addChild(this.smoke2);
      param1.addChild(this.flameView);
      battleService.addGraphicEffect(this.lightEffect);
      this.updateMuzzleState();
      this.time = 0;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:* = param1 / 1000;
      this.time += local3;
      this.updateMuzzleState();
      this.lightEffectPositionProvider.setPosition(this.gunParams.muzzlePosition);
      this.updateFlame(param2);
      this.updateFire();
      return this.updateSmoke(local3,param2);
    }

    private function updateFlame(param1:GameCamera) : void {
      if(this.time <= FLAME_END) {
        this.flameView.visible = true;
        this.flameView.alpha = 1 - this.time / FLAME_END;
        BattleUtils.setObjectPosition3d(this.flameView,this.calculateByGunAxis(-80).toVector3d());
        SFXUtils.alignObjectPlaneToView(flame,this.gunParams.muzzlePosition,this.gunParams.direction,param1.position);
      } else {
        this.container.removeChild(this.flameView);
      }
    }

    private function updateMuzzleState() : void {
      this.weaponPlatform.getBasicGunParams(this.gunParams);
    }

    private function updateFire() : void {
      var local1:* = undefined;
      if(this.time <= FIRE_MIDDLE_TIME) {
        this.setFireVisible(true);
        local1 = this.time / FIRE_MIDDLE_TIME;
        BattleUtils.setObjectPosition3d(this.fire0,this.calculateByGunAxis(FIRE0_AXIS_DISTANCE_MIDDLE * local1).toVector3d());
        this.fire0.scaleX = 1 + 2 * local1;
        this.fire0.scaleY = this.fire0.scaleX;
        this.fire0.scaleZ = this.fire0.scaleX;
        this.fire0.alpha = 0.4 + 0.6 * local1;
        BattleUtils.setObjectPosition3d(this.fire1,this.calculateByGunAxis(FIRE1_AXIS_DISTANCE_MIDDLE * local1).toVector3d());
        this.fire1.scaleX = 1 + local1;
        this.fire1.scaleY = this.fire1.scaleX;
        this.fire1.scaleZ = this.fire1.scaleX;
        this.fire1.alpha = 0.4 + 0.6 * local1;
        BattleUtils.setObjectPosition3d(this.fire2,this.calculateByGunAxis(FIRE2_AXIS_DISTANCE_MIDDLE * local1).toVector3d());
        this.fire2.scaleX = 1 + 0.5 * local1;
        this.fire2.scaleY = this.fire2.scaleX;
        this.fire2.scaleZ = this.fire2.scaleX;
        this.fire2.alpha = 0.2 + 0.8 * local1;
      } else if(this.time <= FIRE_END_TIME) {
        this.setFireVisible(true);
        local1 = (this.time - FIRE_MIDDLE_TIME) / (FIRE_END_TIME - FIRE_MIDDLE_TIME);
        BattleUtils.setObjectPosition3d(this.fire0,this.calculateByGunAxis(FIRE0_AXIS_DISTANCE_MIDDLE + FIRE0_AXIS_DISTANCE_END * local1).toVector3d());
        this.fire0.scaleX = 3 + 1.5 * local1;
        this.fire0.scaleY = this.fire0.scaleX;
        this.fire0.scaleZ = this.fire0.scaleX;
        this.fire0.alpha = 1 - local1;
        BattleUtils.setObjectPosition3d(this.fire1,this.calculateByGunAxis(FIRE1_AXIS_DISTANCE_MIDDLE + FIRE1_AXIS_DISTANCE_END * local1).toVector3d());
        this.fire1.scaleX = 2 + local1;
        this.fire1.scaleY = this.fire1.scaleX;
        this.fire1.scaleZ = this.fire1.scaleX;
        this.fire1.alpha = 1 - local1;
        BattleUtils.setObjectPosition3d(this.fire2,this.calculateByGunAxis(FIRE2_AXIS_DISTANCE_MIDDLE + FIRE2_AXIS_DISTANCE_END * local1).toVector3d());
        this.fire2.scaleX = 1.5 + 0.5 * local1;
        this.fire2.scaleY = this.fire2.scaleX;
        this.fire2.scaleZ = this.fire2.scaleX;
        this.fire2.alpha = 1 - local1;
      } else {
        this.setFireVisible(false);
      }
    }

    private function setFireVisible(param1:Boolean) : * {
      this.fire0.visible = param1;
      this.fire1.visible = param1;
      this.fire2.visible = param1;
    }

    private function updateSmoke(param1:Number, param2:GameCamera) : Boolean {
      var local3:* = undefined;
      var local4:Vector3 = null;
      var local5:Vector3 = null;
      if(this.time <= SMOKE_BEGIN_TIME) {
        this.smoke1.visible = false;
        this.smoke2.visible = false;
        return true;
      }
      if(this.time <= SMOKE_END_TIME) {
        this.smoke1.visible = true;
        this.smoke2.visible = true;
        local3 = (this.time - SMOKE_BEGIN_TIME) / (SMOKE_END_TIME - SMOKE_BEGIN_TIME);
        local4 = this.calculateByGunAxis(140 + SMOKE1_AXIS_DISTANCE * local3,SMOKE1_SOLAR_DISTANCE * local3);
        BattleUtils.setObjectPosition3d(this.smoke1,local4.toVector3d());
        this.smoke1.scaleX = 0.5 + local3;
        this.smoke1.scaleY = this.smoke1.scaleX;
        this.smoke1.scaleZ = this.smoke1.scaleX;
        this.smoke1.rotation -= param1;
        this.smoke1.alpha = 1 - local3;
        local5 = this.calculateByGunAxis(140 + SMOKE2_AXIS_DISTANCE * local3,SMOKE2_SOLAR_DISTANCE * local3);
        BattleUtils.setObjectPosition3d(this.smoke2,local5.toVector3d());
        this.smoke2.rotation += 0.5 * param1;
        this.smoke2.alpha = 1 - local3;
        this.vector.copy(local4).subtract(param2.position).normalize();
        this.smoke1.x += this.vector.x * 20;
        this.smoke1.y += this.vector.y * 20;
        this.smoke1.z += this.vector.z * 20;
        this.smoke2.x += this.vector.x * 25;
        this.smoke2.y += this.vector.y * 25;
        this.smoke2.z += this.vector.z * 25;
        return true;
      }
      this.smoke1.visible = false;
      this.smoke2.visible = false;
      return false;
    }

    private function calculateByGunAxis(param1:Number, param2:Number = 0) : Vector3 {
      this.vector.copy(this.gunParams.direction);
      this.vector.scale(param1);
      this.vector.add(this.gunParams.muzzlePosition);
      this.vector.z += param2;
      return this.vector;
    }

    public function destroy() : void {
      if(this.container != null) {
        this.container.removeChild(this.fire0);
        this.container.removeChild(this.fire1);
        this.container.removeChild(this.fire2);
        this.container.removeChild(this.smoke1);
        this.container.removeChild(this.smoke2);
        this.container.removeChild(this.flameView);
        this.container = null;
      }
      this.lightEffect.kill();
      recycle();
    }

    public function kill() : void {
    }
  }
}
