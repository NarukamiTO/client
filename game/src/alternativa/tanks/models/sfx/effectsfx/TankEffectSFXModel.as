package alternativa.tanks.models.sfx.effectsfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.ultimate.dictator.DictatorStreamEffect;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BitmapData;
  import projects.tanks.client.battlefield.models.effects.activationsfx.EffectSFXRecordCC;
  import projects.tanks.client.battlefield.models.effects.activationsfx.ITankEffectSFXModelBase;
  import projects.tanks.client.battlefield.models.effects.activationsfx.TankEffectSFXModelBase;

  [ModelInfo]
  public class TankEffectSFXModel extends TankEffectSFXModelBase implements ITankEffectSFXModelBase {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    private static const EFFECT_SCALE_XY:Number = 0.6;
    private static const EFFECT_SCALE_Z:Number = 0.3;
    private static const EFFECT_TIME_SCALE:Number = 2.2;
    private static const EFFECT_Z_OFFSET:Number = 80;

    public function TankEffectSFXModel() {
      super();
    }

    public function effectActivated(param1:int) : void {
      var local2:EffectSFXRecordCC = this.getEffectByTag(param1);
      if(local2 != null) {
        this.createStreamEffect(local2.beam.data,local2.star.data);
      }
    }

    private function getEffectByTag(param1:int) : EffectSFXRecordCC {
      var local2:EffectSFXRecordCC = null;
      for each(local2 in getInitParam().effects) {
        if(local2.effectTag == param1) {
          return local2;
        }
      }
      return null;
    }

    private function createStreamEffect(param1:BitmapData, param2:BitmapData) : void {
      var local3:DictatorStreamEffect = DictatorStreamEffect(battleService.getObjectPool().getObject(DictatorStreamEffect));
      var local4:TextureMaterial = textureMaterialRegistry.getMaterial(param1);
      var local5:TextureMaterial = textureMaterialRegistry.getMaterial(param2);
      var local6:Mesh = ITankModel(object.adapt(ITankModel)).getTank().getSkin().getHullMesh();
      local3.init(local4,local5,local6,EFFECT_SCALE_XY,EFFECT_SCALE_Z,EFFECT_Z_OFFSET,EFFECT_TIME_SCALE);
      battleService.addGraphicEffect(local3);
    }
  }
}
