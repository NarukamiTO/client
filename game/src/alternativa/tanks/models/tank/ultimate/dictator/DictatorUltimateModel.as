package alternativa.tanks.models.tank.ultimate.dictator {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.hullcommon.HullCommon;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.utils.TextureMaterialRegistry;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.ultimate.effects.dictator.DictatorUltimateModelBase;
  import projects.tanks.client.battlefield.models.ultimate.effects.dictator.IDictatorUltimateModelBase;

  [ModelInfo]
  public class DictatorUltimateModel extends DictatorUltimateModelBase implements IDictatorUltimateModelBase {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    private var vector:Vector3 = new Vector3();

    public function DictatorUltimateModel() {
      super();
    }

    public function showUltimateUsed(param1:Vector.<IGameObject>) : void {
      var local3:IGameObject = null;
      var local2:IGameObject = HullCommon(object.adapt(HullCommon)).getTankObject();
      this.createStreamEffect(local2,getInitParam().beamScale);
      this.createWaveEffect(local2);
      this.playActivationSound(local2);
      for each(local3 in param1) {
        this.createStreamEffect(local3,getInitParam().secondaryBeamScale);
      }
    }

    private function playActivationSound(param1:IGameObject) : * {
      var local2:ITankModel = ITankModel(param1.adapt(ITankModel));
      var local3:Mesh = local2.getTank().getSkin().getHullMesh();
      var local4:Sound3D = Sound3D.create(getInitParam().activationSound.sound);
      this.vector.reset(local3.x,local3.y,local3.z);
      var local5:GameCamera = battleService.getBattleScene3D().getCamera();
      local4.play(0,0);
      local4.checkVolume(local5.position,this.vector,local5.xAxis);
    }

    private function createWaveEffect(param1:IGameObject) : void {
      var local2:DictatorWaveEffect = DictatorWaveEffect(battleService.getObjectPool().getObject(DictatorWaveEffect));
      var local3:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().wave.data);
      var local4:Mesh = ITankModel(param1.adapt(ITankModel)).getTank().getSkin().getHullMesh();
      local2.init(local3,local4);
      battleService.addGraphicEffect(local2);
    }

    private function createStreamEffect(param1:IGameObject, param2:Number) : void {
      var local3:DictatorStreamEffect = DictatorStreamEffect(battleService.getObjectPool().getObject(DictatorStreamEffect));
      var local4:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().beam.data);
      var local5:TextureMaterial = textureMaterialRegistry.getMaterial(getInitParam().star.data);
      var local6:Mesh = ITankModel(param1.adapt(ITankModel)).getTank().getSkin().getHullMesh();
      local3.init(local4,local5,local6,param2,param2);
      battleService.addGraphicEffect(local3);
    }
  }
}
