package alternativa.tanks.models.tank.ultimate.hornet {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
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
  import projects.tanks.client.battlefield.models.ultimate.effects.hornet.HornetUltimateModelBase;
  import projects.tanks.client.battlefield.models.ultimate.effects.hornet.IHornetUltimateModelBase;

  [ModelInfo]
  public class HornetUltimateModel extends HornetUltimateModelBase implements IHornetUltimateModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var vector:Vector3 = new Vector3();
    private var battleEventSupport:BattleEventSupport;

    public function HornetUltimateModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
    }

    public function objectLoaded() : void {
      this.battleEventSupport.activateHandlers();
    }

    public function objectUnloaded() : void {
      this.battleEventSupport.deactivateHandlers();
    }

    private function onTankLoaded(param1:TankLoadedEvent) : void {
      var event:TankLoadedEvent = param1;
      object = ITankModel(object.adapt(ITankModel)).getTankSet().hull;
      try {
        if(getInitParam() != null && getInitParam().effectEnabled) {
          this.showUltimateRadarIsTurnedOn();
        }
      }
      finally {
        popObject();
      }
    }

    public function showUltimateRadarIsTurnedOn() : void {
      var local1:IGameObject = HullCommon(object.adapt(HullCommon)).getTankObject();
      var local2:ITankModel = ITankModel(local1.adapt(ITankModel));
      var local3:Mesh = local2.getTank().getSkin().getHullMesh();
      var local4:Sound3D = Sound3D.create(getInitParam().effectStartSound.sound);
      this.vector.reset(local3.x,local3.y,local3.z);
      var local5:GameCamera = battleService.getBattleScene3D().getCamera();
      local4.play(0,0);
      local4.checkVolume(local5.position,this.vector,local5.xAxis);
      var local6:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().ring.data);
      var local7:Sound3D = Sound3D.create(getInitParam().sonarSound.sound);
      var local8:RadarEffect = this.createRadarEffect(local3,local6,local7,local2.isLocal());
      putData(RadarEffect,local8);
    }

    public function showUltimateRadarIsTurnedOff() : void {
      var local1:RadarEffect = RadarEffect(getData(RadarEffect));
      if(local1 != null) {
        local1.fadeOut();
      }
    }

    private function createRadarEffect(param1:Mesh, param2:TextureMaterial, param3:Sound3D, param4:Boolean) : RadarEffect {
      var local5:RadarEffect = param4 ? RadarEffectSmall(battleService.getObjectPool().getObject(RadarEffectSmall)) : RadarEffectBig(battleService.getObjectPool().getObject(RadarEffectBig));
      local5.init(param2,param1,param3);
      battleService.addGraphicEffect(local5);
      return local5;
    }
  }
}
