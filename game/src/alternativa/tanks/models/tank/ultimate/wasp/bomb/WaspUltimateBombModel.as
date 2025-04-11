package alternativa.tanks.models.tank.ultimate.wasp.bomb {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.engine3d.UVFrame;
  import alternativa.tanks.models.battle.facilities.BattleFacilities;
  import alternativa.tanks.models.battle.facilities.FacilitySphericalZone;
  import alternativa.tanks.models.battle.facilities.ICommonFacility;
  import alternativa.tanks.models.battle.gui.inventory.InventorySoundService;
  import alternativa.tanks.models.battle.meteor.nuclear.NuclearBangEffect;
  import alternativa.tanks.models.tank.LocalTankInfoService;
  import alternativa.tanks.models.tank.event.TankEntityCreationListener;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.utils.GraphicsUtils;
  import alternativa.utils.TextureMaterialRegistry;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.client.battlefield.models.ultimate.effects.wasp.bomb.IWaspUltimateBombModelBase;
  import projects.tanks.client.battlefield.models.ultimate.effects.wasp.bomb.WaspUltimateBombCC;
  import projects.tanks.client.battlefield.models.ultimate.effects.wasp.bomb.WaspUltimateBombModelBase;
  import projects.tanks.client.battlefield.models.user.tank.TankLogicState;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  [ModelInfo]
  public class WaspUltimateBombModel extends WaspUltimateBombModelBase implements IWaspUltimateBombModelBase, ObjectLoadPostListener, ObjectUnloadListener, TankEntityCreationListener {
    [Inject]
    public static var inventorySoundService:InventorySoundService;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var localTankInfoService:LocalTankInfoService;

    private static const DECAL_RADIUS:Number = 1000;
    private static const NUKE_BANG_VOLUME:Number = 2;

    public function WaspUltimateBombModel() {
      super();
    }

    private static function createUVFrame(param1:TextureMaterial, param2:MultiframeTextureResource) : Vector.<UVFrame> {
      return GraphicsUtils.getUVFramesFromTexture(param1.texture,param2.frameWidth,param2.frameHeight,param2.numFrames);
    }

    public function objectLoadedPost() : void {
      this.registerCheckZone();
      var local1:WaspBombData = this.createBombData();
      putData(WaspBombData,local1);
      this.createBombSpawnSound();
      this.createCountdownAnimation(local1);
    }

    private function registerCheckZone() : void {
      this.battleFacilities().addCheckZone(object,this.getZoneCenter(),this.sphericalZone().getRadius(),false);
    }

    private function battleFacilities() : BattleFacilities {
      return BattleFacilities(object.space.rootObject.adapt(BattleFacilities));
    }

    private function getZoneCenter() : Vector3 {
      var local1:Vector3 = this.battleFacility().getCenter();
      local1.z += this.sphericalZone().getCenterOffsetZ();
      return local1;
    }

    private function battleFacility() : ICommonFacility {
      return ICommonFacility(object.adapt(ICommonFacility));
    }

    private function sphericalZone() : FacilitySphericalZone {
      return FacilitySphericalZone(object.adapt(FacilitySphericalZone));
    }

    private function createBombData() : WaspBombData {
      var local1:WaspBombData = new WaspBombData();
      if(localTankInfoService.isLocalTankLoaded()) {
        local1.localTank = localTankInfoService.getLocalTank();
      }
      return local1;
    }

    private function createBombSpawnSound() : void {
      var local1:Vector3 = this.battleFacility().getPosition();
      var local2:Sound3D = Sound3D.create(getInitParam().bombPlacedSound.sound);
      battleService.addSound3DEffect(Sound3DEffect.create(local1,local2));
    }

    private function createCountdownAnimation(param1:LocalTankPositionProvider) : void {
      var local2:WaspUltimateBombCC = getInitParam();
      var local3:TextureAnimation = this.createAnimation(local2.countdown);
      var local4:TextureAnimation = this.createAnimation(local2.farCountdown);
      var local5:Sound3D = Sound3D.create(local2.bombBeepSound.sound);
      var local6:ICommonFacility = this.battleFacility();
      var local7:WaspUltimateCountdownEffect = WaspUltimateCountdownEffect(battleService.getObjectPool().getObject(WaspUltimateCountdownEffect));
      local7.init(local6.getPosition(),this.getZoneCenter(),this.sphericalZone().getRadius(),local2.timeLeft * 0.001,param1,this.isBombHarmlessForLocalTank(),local3,local4,local5);
      battleService.getBattleScene3D().addGraphicEffect(local7);
      putData(WaspUltimateCountdownEffect,local7);
    }

    private function createAnimation(param1:MultiframeTextureResource) : TextureAnimation {
      var local2:TextureMaterial = textureMaterialRegistry.getMaterial(param1.data);
      var local3:Vector.<UVFrame> = createUVFrame(local2,param1);
      return new TextureAnimation(local2,local3);
    }

    private function isBombHarmlessForLocalTank() : Boolean {
      var local1:ICommonFacility = null;
      var local2:Tank = null;
      var local3:BattleTeam = null;
      if(localTankInfoService.isLocalTankLoaded()) {
        local1 = this.battleFacility();
        if(local1.getOwner() != localTankInfoService.getLocalTankObject()) {
          local2 = localTankInfoService.getLocalTank();
          local3 = local1.getTeam();
          return local2.isSameTeam(local3);
        }
      }
      return true;
    }

    public function onTankEntityCreated(param1:Tank, param2:Boolean, param3:TankLogicState) : void {
      var local4:WaspBombData = null;
      var local5:WaspUltimateCountdownEffect = null;
      if(param2) {
        local4 = WaspBombData(getData(WaspBombData));
        local4.localTank = param1;
        local5 = WaspUltimateCountdownEffect(getData(WaspUltimateCountdownEffect));
        local5.isHarmless = this.isBombHarmlessForLocalTank();
      }
    }

    public function bang() : void {
      this.stopCountdownEffect();
      var local1:WaspUltimateBombCC = getInitParam();
      var local2:TextureMaterial = textureMaterialRegistry.getMaterial(local1.nuclearBangFlame.data);
      var local3:TextureMaterial = textureMaterialRegistry.getMaterial(local1.nuclearBangLight.data);
      var local4:TextureMaterial = textureMaterialRegistry.getMaterial(local1.nuclearBangSmoke.data);
      var local5:TextureMaterial = textureMaterialRegistry.getMaterial(local1.nuclearBangWave.data);
      var local6:NuclearBangEffect = new NuclearBangEffect(battleService.getObjectPool(),local3,local5,local4,local2);
      var local7:BattleScene3D = battleService.getBattleScene3D();
      var local8:Vector3 = this.battleFacility().getPosition();
      local6.play(local8,local7);
      var local9:TextureMaterial = textureMaterialRegistry.getMaterial(local1.craterDecal.data);
      var local10:Vector3 = local8.clone().add(Vector3.Z_AXIS.clone().scale(5));
      local7.addDecal(local8,local10,DECAL_RADIUS,local9);
      var local11:GameCamera = local7.getCamera();
      var local12:Sound3D = Sound3D.create(local1.nuclearBangSound.sound);
      local12.checkVolume(local11.position,local8,local11.xAxis);
      local12.volume = NUKE_BANG_VOLUME;
      battleService.addSound3DEffect(Sound3DEffect.create(local8,local12));
    }

    public function objectUnloaded() : void {
      this.battleFacilities().removeCheckZone(object);
      this.stopCountdownEffect();
    }

    private function stopCountdownEffect() : void {
      var local1:WaspUltimateCountdownEffect = WaspUltimateCountdownEffect(clearData(WaspUltimateCountdownEffect));
      if(local1 != null) {
        local1.stop();
      }
    }
  }
}
