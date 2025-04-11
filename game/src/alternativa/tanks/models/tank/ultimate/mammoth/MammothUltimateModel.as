package alternativa.tanks.models.tank.ultimate.mammoth {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.TankLoadedEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.battle.facilities.BattleFacilities;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.hullcommon.HullCommon;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.types.Long;
  import alternativa.utils.TextureMaterialRegistry;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.ultimate.effects.mammoth.IMammothUltimateModelBase;
  import projects.tanks.client.battlefield.models.ultimate.effects.mammoth.MammothUltimateCC;
  import projects.tanks.client.battlefield.models.ultimate.effects.mammoth.MammothUltimateModelBase;

  [ModelInfo]
  public class MammothUltimateModel extends MammothUltimateModelBase implements IMammothUltimateModelBase, ObjectLoadListener, ObjectUnloadListener, ImpactEnable {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    private static const SPARKLE_Z_OFFSET:int = 150;

    private var sparkSoundIndex:int = -1;
    private var vector:Vector3 = new Vector3();
    private var battleEventSupport:BattleEventSupport;

    public function MammothUltimateModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
    }

    private function onTankLoaded(param1:TankLoadedEvent) : void {
      var event:TankLoadedEvent = param1;
      object = ITankModel(object.adapt(ITankModel)).getTankSet().hull;
      try {
        if(getInitParam() != null && getInitParam().active) {
          this.activateField();
        }
      }
      finally {
        popObject();
      }
    }

    public function activateField() : void {
      var local1:MammothUltimateCC = getInitParam();
      var local2:Sound3D = Sound3D.create(local1.effectStartSound.sound);
      var local3:Sound3D = Sound3D.create(local1.effectLoopSound.sound);
      var local4:Sound3D = Sound3D.create(local1.effectStopSound.sound);
      var local5:IGameObject = HullCommon(object.adapt(HullCommon)).getTankObject();
      var local6:Tank = ITankModel(local5.adapt(ITankModel)).getTank();
      var local7:TextureMaterial = textureMaterialRegistry.getMaterial(local1.heart.data);
      var local8:TextureMaterial = textureMaterialRegistry.getMaterial(local1.shine.data);
      var local9:Mesh = local6.getSkin().getHullMesh();
      var local10:FieldEffect = FieldEffect(battleService.getObjectPool().getObject(FieldEffect));
      local10.init(local8,local7,local9,local2,local3,local4);
      battleService.addGraphicEffect(local10);
      putData(FieldEffect,local10);
      this.getBattleFacilitites().addDynamicCheckZone(object,local6,BattleUtils.toClientScale(local1.effectRadius),false);
    }

    public function deactivateField() : void {
      this.stopFieldEffect(true);
    }

    public function stopFieldEffect(param1:Boolean) : void {
      var local2:FieldEffect = FieldEffect(getData(FieldEffect));
      if(local2 != null) {
        local2.stop(param1);
        clearData(FieldEffect);
      }
      this.getBattleFacilitites().removeCheckZone(object);
    }

    private function getBattleFacilitites() : BattleFacilities {
      return BattleFacilities(object.space.rootObject.adapt(BattleFacilities));
    }

    public function damageByField(param1:Long) : void {
      var local4:Mesh = null;
      var local5:ExplosionEffect = null;
      var local2:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().sparkles.data);
      var local3:IGameObject = object.space.getObject(param1);
      if(local3 != null) {
        local4 = ITankModel(local3.adapt(ITankModel)).getTank().getSkin().getHullMesh();
        local5 = ExplosionEffect(battleService.getObjectPool().getObject(ExplosionEffect));
        local5.init(local2,local4.x,local4.y,local4.z + SPARKLE_Z_OFFSET);
        battleService.addGraphicEffect(local5);
        this.playSparkSound(this.sparkSoundIndex,local4);
      }
    }

    private function playSparkSound(param1:int, param2:Mesh) : void {
      var local5:Sound3D = null;
      var local3:GameCamera = battleService.getBattleScene3D().getCamera();
      var local4:MammothUltimateCC = getInitParam();
      param1 = (param1 + 1) % 4;
      switch(param1) {
        case 0:
          local5 = Sound3D.create(local4.effectSparks1Sound.sound);
          break;
        case 1:
          local5 = Sound3D.create(local4.effectSparks2Sound.sound);
          break;
        case 2:
          local5 = Sound3D.create(local4.effectSparks3Sound.sound);
          break;
        case 3:
          local5 = Sound3D.create(local4.effectSparks4Sound.sound);
      }
      this.vector.reset(param2.x,param2.y,param2.z + SPARKLE_Z_OFFSET);
      local5.play(0,0);
      local5.checkVolume(local3.position,this.vector,local3.xAxis);
    }

    public function isImpactEnabled() : Boolean {
      var local1:FieldEffect = FieldEffect(getData(FieldEffect));
      return local1 == null;
    }

    public function objectLoaded() : void {
      this.battleEventSupport.activateHandlers();
    }

    public function objectUnloaded() : void {
      this.battleEventSupport.deactivateHandlers();
      this.stopFieldEffect(false);
    }
  }
}
