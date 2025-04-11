package alternativa.tanks.models.tank.ultimate.viking {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.event.TankEntityCreationListener;
  import alternativa.tanks.models.tank.hullcommon.HullCommon;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.utils.TextureMaterialRegistry;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.ultimate.effects.viking.IVikingUltimateModelBase;
  import projects.tanks.client.battlefield.models.ultimate.effects.viking.VikingUltimateModelBase;
  import projects.tanks.client.battlefield.models.user.tank.TankLogicState;

  [ModelInfo]
  public class VikingUltimateModel extends VikingUltimateModelBase implements IVikingUltimateModelBase, TankEntityCreationListener, ObjectUnloadListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    private var vector:Vector3 = new Vector3();

    public function VikingUltimateModel() {
      super();
    }

    private function createBurnEffect(param1:IGameObject, param2:TextureMaterial, param3:TextureMaterial, param4:Sound3D) : BurningEffect {
      var local5:BurningEffect = BurningEffect(battleService.getObjectPool().getObject(BurningEffect));
      var local6:Mesh = ITankModel(param1.adapt(ITankModel)).getTank().getSkin().getHullMesh();
      local5.init(param2,param3,local6,param4);
      battleService.addGraphicEffect(local5);
      var local7:Sound3D = Sound3D.create(getInitParam().effectStartSound.sound);
      var local8:GameCamera = battleService.getBattleScene3D().getCamera();
      this.vector.reset(local6.x,local6.y,local6.z);
      local7.play(0,0);
      local7.checkVolume(local8.position,this.vector,local8.xAxis);
      return local5;
    }

    public function effectActivated() : void {
      var local1:IGameObject = HullCommon(object.adapt(HullCommon)).getTankObject();
      var local2:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().flame.data);
      var local3:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().smoke.data);
      var local4:Sound3D = Sound3D.create(getInitParam().effectSound.sound);
      var local5:BurningEffect = this.createBurnEffect(local1,local2,local3,local4);
      putData(BurningEffect,local5);
    }

    public function effectDeactivated() : void {
      var local2:IGameObject = null;
      var local3:Mesh = null;
      var local4:Sound3D = null;
      var local5:GameCamera = null;
      var local1:BurningEffect = BurningEffect(getData(BurningEffect));
      if(local1 != null) {
        local1.stop();
        local2 = HullCommon(object.adapt(HullCommon)).getTankObject();
        if(local2.hasModel(ITankModel)) {
          local3 = ITankModel(local2.adapt(ITankModel)).getTank().getSkin().getHullMesh();
          local4 = Sound3D.create(getInitParam().effectEndSound.sound);
          local5 = battleService.getBattleScene3D().getCamera();
          this.vector.reset(local3.x,local3.y,local3.z);
          local4.play(0,0);
          local4.checkVolume(local5.position,this.vector,local5.xAxis);
        }
      }
    }

    public function onTankEntityCreated(param1:Tank, param2:Boolean, param3:TankLogicState) : void {
      if(getInitParam().effectEnabled) {
        this.effectActivated();
      }
    }

    public function objectUnloaded() : void {
      var local1:BurningEffect = BurningEffect(getData(BurningEffect));
      if(local1 != null) {
        local1.stop();
      }
    }
  }
}
