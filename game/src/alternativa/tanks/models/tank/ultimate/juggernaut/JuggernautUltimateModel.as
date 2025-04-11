package alternativa.tanks.models.tank.ultimate.juggernaut {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.effects.ultimate.SparkleSphereEffect;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.hullcommon.HullCommon;
  import alternativa.tanks.models.tank.ultimate.UltimateModel;
  import alternativa.tanks.sfx.Sound3D;
  import flash.geom.ColorTransform;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.ultimate.effects.juggernaut.IJuggernautUltimateModelBase;
  import projects.tanks.client.battlefield.models.ultimate.effects.juggernaut.JuggernautUltimateModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  [ModelInfo]
  public class JuggernautUltimateModel extends JuggernautUltimateModelBase implements IJuggernautUltimateModelBase {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    private var vector:Vector3 = new Vector3();

    public function JuggernautUltimateModel() {
      super();
    }

    public function showUltimateUsed(param1:Vector.<IGameObject>) : void {
      var local3:IGameObject = null;
      var local2:IGameObject = HullCommon(object.adapt(HullCommon)).getTankObject();
      this.playActivationSound(local2);
      this.createSparkleEffect(local2,true);
      for each(local3 in param1) {
        this.createSparkleEffect(local3,false);
      }
    }

    private function playActivationSound(param1:IGameObject) : * {
      var local2:ITankModel = ITankModel(param1.adapt(ITankModel));
      var local3:Mesh = local2.getTank().getSkin().getHullMesh();
      var local4:Sound3D = Sound3D.create(getInitParam().activateSound.sound);
      this.vector.reset(local3.x,local3.y,local3.z);
      var local5:GameCamera = battleService.getBattleScene3D().getCamera();
      local4.play(0,0);
      local4.checkVolume(local5.position,this.vector,local5.xAxis);
    }

    private function createSparkleEffect(param1:IGameObject, param2:Boolean) : void {
      var local3:ITankModel = ITankModel(param1.adapt(ITankModel));
      var local4:IGameObject = local3.getTankSet().hull;
      var local5:Tank = local3.getTank();
      var local6:Boolean = local4 != object;
      var local7:TextureMaterial = new TextureMaterial(getInitParam().sparkImage.data);
      var local8:ColorTransform = UltimateModel.parseColorTransform(getInitParam().positiveColorTransform);
      var local9:ColorTransform = UltimateModel.parseColorTransform(getInitParam().positiveColorTransform);
      var local10:SparkleSphereEffect = SparkleSphereEffect(battleService.getObjectPool().getObject(SparkleSphereEffect));
      var local11:ColorTransform = param2 ? local8 : local9;
      local10.init(local7,local5.getSkin().getHullMesh(),local6,local11);
      battleService.addGraphicEffect(local10);
    }
  }
}
