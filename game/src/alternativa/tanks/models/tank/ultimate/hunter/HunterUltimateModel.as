package alternativa.tanks.models.tank.ultimate.hunter {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.TankLoadedEvent;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.hullcommon.HullCommon;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.utils.TextureMaterialRegistry;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.ultimate.effects.hunter.HunterUltimateCC;
  import projects.tanks.client.battlefield.models.ultimate.effects.hunter.HunterUltimateModelBase;
  import projects.tanks.client.battlefield.models.ultimate.effects.hunter.IHunterUltimateModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;

  [ModelInfo]
  public class HunterUltimateModel extends HunterUltimateModelBase implements IHunterUltimateModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var battleEventSupport:BattleEventSupport;

    public function HunterUltimateModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
    }

    public function objectLoaded() : void {
      this.battleEventSupport.activateHandlers();
      var local1:HunterUltimateCC = getInitParam();
      local1.originPointZOffset = BattleUtils.toClientScale(local1.originPointZOffset);
    }

    public function objectUnloaded() : void {
      this.battleEventSupport.deactivateHandlers();
    }

    private function onTankLoaded(param1:TankLoadedEvent) : void {
      var event:TankLoadedEvent = param1;
      object = ITankModel(object.adapt(ITankModel)).getTankSet().hull;
      try {
        if(getInitParam() != null && getInitParam().preparing) {
          this.startCharging();
        }
      }
      finally {
        popObject();
      }
    }

    private function createChargingEffect(param1:TextureMaterial, param2:IGameObject, param3:Number) : EnergyEffect {
      var local4:EnergyEffect = EnergyEffect(battleService.getObjectPool().getObject(EnergyEffect));
      var local5:Mesh = ITankModel(param2.adapt(ITankModel)).getTank().getSkin().getHullMesh();
      var local6:Sound3D = Sound3D.create(getInitParam().effectStartSound.sound);
      local4.init(param1,local5,param3,local6);
      battleService.addGraphicEffect(local4);
      return local4;
    }

    private function createLightningEffect(param1:TextureMaterial, param2:IGameObject, param3:Vector3, param4:Sound3D, param5:Number) : void {
      var local6:LightningEffect = LightningEffect(battleService.getObjectPool().getObject(LightningEffect));
      var local7:Mesh = ITankModel(param2.adapt(ITankModel)).getTank().getSkin().getHullMesh();
      local6.init(param1,local7,param3,param4,param5);
      battleService.addGraphicEffect(local6);
    }

    public function dispel(param1:Vector.<Vector3d>) : void {
      var local6:* = undefined;
      var local2:Sound3D = Sound3D.create(getInitParam().hitSound.sound);
      var local3:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().lightning.data);
      var local4:IGameObject = HullCommon(object.adapt(HullCommon)).getTankObject();
      var local5:Number = getInitParam().originPointZOffset;
      if(param1.length == 0) {
        this.playFailSound(local4);
        return;
      }
      for each(local6 in param1) {
        this.createLightningEffect(local3,local4,BattleUtils.getVector3(local6),local2,local5);
      }
    }

    private function playFailSound(param1:IGameObject) : void {
      var local2:GameCamera = battleService.getBattleScene3D().getCamera();
      var local3:Mesh = ITankModel(param1.adapt(ITankModel)).getTank().getSkin().getHullMesh();
      var local4:Sound3D = Sound3D.create(getInitParam().failSound.sound);
      local4.play(0,0);
      local4.checkVolume(local2.position,new Vector3(local3.x,local3.y,local3.z),local2.xAxis);
    }

    public function startCharging() : void {
      var local1:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().energy.data);
      var local2:IGameObject = HullCommon(object.adapt(HullCommon)).getTankObject();
      var local3:EnergyEffect = this.createChargingEffect(local1,local2,this.getChargingTime());
      putData(EnergyEffect,local3);
    }

    public function cancel() : void {
      this.stopCharging();
    }

    public function stopCharging() : void {
      var local1:EnergyEffect = EnergyEffect(getData(EnergyEffect));
      if(local1 != null) {
        local1.stop();
      }
    }

    private function getChargingTime() : Number {
      return getInitParam().chargingTimeMillis / 1000;
    }
  }
}
