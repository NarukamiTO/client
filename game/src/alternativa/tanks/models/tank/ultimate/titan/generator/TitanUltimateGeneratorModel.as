package alternativa.tanks.models.tank.ultimate.titan.generator {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.battle.facilities.BattleFacilities;
  import alternativa.tanks.models.battle.facilities.FacilitySphericalZone;
  import alternativa.tanks.models.battle.facilities.ICommonFacility;
  import alternativa.tanks.models.controlpoints.sound.KeyPointSoundEffect;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.event.TankEntityCreationListener;
  import alternativa.tanks.models.tank.ultimate.titan.ShieldBeamEffect;
  import alternativa.tanks.models.tank.ultimate.titan.ShieldEffect;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.ISound3DEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.types.Long;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.media.Sound;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.ultimate.effects.titan.generator.ITitanUltimateGeneratorModelBase;
  import projects.tanks.client.battlefield.models.ultimate.effects.titan.generator.TitanUltimateGeneratorCC;
  import projects.tanks.client.battlefield.models.ultimate.effects.titan.generator.TitanUltimateGeneratorModelBase;
  import projects.tanks.client.battlefield.models.user.tank.TankLogicState;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;

  [ModelInfo]
  public class TitanUltimateGeneratorModel extends TitanUltimateGeneratorModelBase implements ITitanUltimateGeneratorModelBase, ObjectLoadPostListener, ObjectUnloadListener, TankEntityCreationListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var materialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var userInfoService:IUserInfoService;

    private static const SPHERE_SPRITE_SIZE:Number = 150;

    private var coverOnTank:Dictionary = new Dictionary();

    public function TitanUltimateGeneratorModel() {
      super();
    }

    public function objectLoadedPost() : void {
      var local4:Long = null;
      this.registerCheckZone();
      var local1:TitanUltimateGeneratorCC = getInitParam();
      local1.zoneRadiusFakeReducing = BattleUtils.toClientScale(local1.zoneRadiusFakeReducing);
      var local2:Vector3 = this.battleFacility().getCenter();
      local2.z += this.sphericalZone().getCenterOffsetZ();
      var local3:TitanUltimateResources = new TitanUltimateResources(getInitParam(),materialRegistry);
      putData(ShieldGeneratorData,new ShieldGeneratorData(local2,local3,this.createGeneratorSoundEffect(local2),this.createGeneratorSphereEffect(local3.sphere,local2),local3.sphereRotationAngle));
      this.playShortSound3D(getInitParam().generatorActivationSound.sound,local2);
      this.createShieldEffect();
      for each(local4 in getInitParam().coveredTanksIds) {
        this.coverTank(local4);
      }
    }

    private function registerCheckZone() : void {
      this.battleFacilities().addCheckZone(object,this.getZoneCenter(),this.sphericalZone().getRadius(),false);
    }

    private function battleFacilities() : BattleFacilities {
      return BattleFacilities(object.space.rootObject.adapt(BattleFacilities));
    }

    private function getZoneCenter() : Vector3 {
      var local1:Vector3 = this.battleFacility().getPosition();
      local1.z += this.sphericalZone().getCenterOffsetZ();
      return local1;
    }

    private function battleFacility() : ICommonFacility {
      return ICommonFacility(object.adapt(ICommonFacility));
    }

    private function sphericalZone() : FacilitySphericalZone {
      return FacilitySphericalZone(object.adapt(FacilitySphericalZone));
    }

    private function createGeneratorSoundEffect(param1:Vector3) : ISound3DEffect {
      var local2:KeyPointSoundEffect = KeyPointSoundEffect(this.getObjectFromPool(KeyPointSoundEffect));
      local2.init(getInitParam().generatorLoopSound.sound,param1);
      this.addSound3DEffect(local2);
      return local2;
    }

    private function addSound3DEffect(param1:ISound3DEffect) : void {
      battleService.getBattleRunner().getSoundManager().addEffect(param1);
    }

    private function createGeneratorSphereEffect(param1:TextureAnimation, param2:Vector3) : GraphicEffect {
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.getObjectFromPool(StaticObject3DPositionProvider));
      local3.init(param2,0);
      var local4:AnimatedSpriteEffect = AnimatedSpriteEffect(this.getObjectFromPool(AnimatedSpriteEffect));
      local4.initLooped(SPHERE_SPRITE_SIZE,SPHERE_SPRITE_SIZE,param1,0,local3);
      battleService.getBattleScene3D().addGraphicEffect(local4);
      return local4;
    }

    private function getObjectFromPool(param1:Class) : Object {
      return battleService.getObjectPool().getObject(param1);
    }

    private function playShortSound3D(param1:Sound, param2:Vector3) : void {
      var local3:Sound3DEffect = Sound3DEffect.create(param2,Sound3D.create(param1));
      this.addSound3DEffect(local3);
    }

    public function objectUnloaded() : void {
      this.battleFacilities().removeCheckZone(object);
      this.removeShield();
      var local1:ShieldGeneratorData = this.getShieldGeneratorData();
      if(local1 != null) {
        this.playShortSound3D(getInitParam().generatorDeactivationSound.sound,local1.spherePosition);
        local1.visualEffect.kill();
        local1.soundEffect.kill();
      }
      this.coverOnTank = new Dictionary();
    }

    public function coverTank(param1:Long) : void {
      this.getShieldGeneratorData().cover(param1);
      this.increaseTankCoverCounter(param1);
      this.createEffectsForExistingTank(param1);
    }

    private function createEffectsForExistingTank(param1:Long) : void {
      var local2:Tank = this.getTank(param1);
      if(local2 != null) {
        this.createBeamEffect(local2);
      }
    }

    private function createShieldEffect() : void {
      this.createShieldSoundEffect();
      var local1:ShieldGeneratorData = this.getShieldGeneratorData();
      var local2:ShieldEffect = ShieldEffect(this.getObjectFromPool(ShieldEffect));
      var local3:Number = this.sphericalZone().getRadius() - getInitParam().zoneRadiusFakeReducing;
      local2.init(local1.resources.cellTexture,local1.resources.geosphere,this.getZoneCenter(),local3,local1.rotationAngle);
      battleService.addGraphicEffect(local2);
      putData(ShieldEffect,local2);
    }

    private function createShieldSoundEffect() : void {
      this.playShortSound3D(getInitParam().shieldOnSound.sound,this.getZoneCenter());
    }

    private function createBeamEffect(param1:Tank) : void {
      var local2:ShieldBeamEffect = ShieldBeamEffect(this.getObjectFromPool(ShieldBeamEffect));
      var local3:ShieldGeneratorData = this.getShieldGeneratorData();
      var local4:TitanUltimateResources = local3.resources;
      local2.init(param1.getSkin().getTurret3D(),local3.spherePosition,local4.rayMaterial,local4.rayTipMaterial);
      battleService.addGraphicEffect(local2);
      local3.addBeam(param1.getUser().id,local2);
    }

    private function getShieldGeneratorData() : ShieldGeneratorData {
      return ShieldGeneratorData(getData(ShieldGeneratorData));
    }

    private function getTank(param1:Long) : Tank {
      var local2:IGameObject = object.space.getObject(param1);
      return local2 != null ? ITankModel(local2.adapt(ITankModel)).getTank() : null;
    }

    public function uncoverTank(param1:Long, param2:Boolean) : void {
      var local3:ShieldGeneratorData = this.getShieldGeneratorData();
      local3.uncover(param1);
      var local4:int = this.decreaseTankCoverCounter(param1);
    }

    public function onTankEntityCreated(param1:Tank, param2:Boolean, param3:TankLogicState) : void {
      var local4:ShieldGeneratorData = this.getShieldGeneratorData();
      var local5:Long = param1.getUser().id;
      if(local4.isTankCovered(local5)) {
        this.createEffectsForExistingTank(local5);
      }
    }

    private function removeShield() : void {
      var local1:ShieldEffect = ShieldEffect(getData(ShieldEffect));
      if(local1 != null) {
        local1.stop();
        this.playShortSound3D(getInitParam().shieldOffSound.sound,this.getZoneCenter());
      }
    }

    private function increaseTankCoverCounter(param1:Long) : void {
      this.coverOnTank[param1] = int(this.coverOnTank[param1]) + 1;
    }

    private function decreaseTankCoverCounter(param1:Long) : int {
      var local2:int = Math.max(0,int(this.coverOnTank[param1]) - 1);
      this.coverOnTank[param1] = local2;
      return local2;
    }
  }
}
