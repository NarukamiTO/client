package alternativa.tanks.models.bonus.common {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.bonuses.BattleBonus;
  import alternativa.tanks.bonuses.BattleBonusData;
  import alternativa.tanks.bonuses.Bonus;
  import alternativa.tanks.models.bonus.bonuslight.BonusLight;
  import alternativa.tanks.models.bonus.bonuslight.IBonusLight;
  import alternativa.tanks.models.effects.common.IBonusCommonModel;
  import alternativa.types.Long;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BitmapData;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.StubBitmapData;
  import projects.tanks.client.battlefield.models.bonus.bonus.common.BonusCommonModelBase;
  import projects.tanks.client.battlefield.models.bonus.bonus.common.IBonusCommonModelBase;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  [ModelInfo]
  public class BonusCommonModel extends BonusCommonModelBase implements IBonusCommonModelBase, ObjectLoadListener, ObjectUnloadListener, IBonusCommonModel {
    [Inject]
    public static var materialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var battleService:BattleService;

    private static var stubBitmapData:BitmapData;

    public function BonusCommonModel() {
      super();
    }

    private static function getMeshFromResource(param1:Tanks3DSResource) : Mesh {
      var local2:Mesh = Mesh(param1.objects[0]);
      var local3:BitmapData = param1.getTextureForObject(0);
      if(local3 == null) {
        local3 = getStubBitmapData();
      }
      var local4:Mesh = Mesh(local2.clone());
      var local5:TextureMaterial = materialRegistry.getMaterial(local3);
      local5.resolution = 1;
      local4.setMaterialToAllFaces(local5);
      return local4;
    }

    private static function getStubBitmapData() : BitmapData {
      if(stubBitmapData == null) {
        stubBitmapData = new StubBitmapData(65280);
      }
      return stubBitmapData;
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:BattleBonusData = new BattleBonusData();
      local1.boxMesh = getMeshFromResource(getInitParam().boxResource);
      local1.parachuteOuterMesh = getMeshFromResource(getInitParam().parachuteResource);
      local1.parachuteInnerMesh = getMeshFromResource(getInitParam().parachuteInnerResource);
      local1.cordsMaterial = materialRegistry.getMaterial(getInitParam().cordResource.data);
      local1.cordsMaterial.resolution = 5;
      if(getInitParam().pickupSoundResource != null) {
        local1.pickupSound = getInitParam().pickupSoundResource.sound;
      }
      var local2:BonusLight = IBonusLight(object.adapt(IBonusLight)).getBonusLight();
      local1.lightColor = local2.getLightColor().getColor();
      local1.lightIntensity = local2.getLightColor().getIntensity();
      local1.attenuationBegin = local2.getAttenuationBegin();
      local1.attenuationEnd = local2.getAttenuationEnd();
      putData(BattleBonusData,local1);
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      var local1:BattleBonusData = BattleBonusData(getData(BattleBonusData));
      materialRegistry.releaseMaterial(this.getMeshMaterial(local1.boxMesh));
      materialRegistry.releaseMaterial(this.getMeshMaterial(local1.parachuteInnerMesh));
      materialRegistry.releaseMaterial(this.getMeshMaterial(local1.parachuteOuterMesh));
      materialRegistry.releaseMaterial(local1.cordsMaterial);
    }

    private function getMeshMaterial(param1:Mesh) : TextureMaterial {
      var local2:Face = param1.faces[0];
      return TextureMaterial(local2.material);
    }

    public function getBonus(param1:Long) : Bonus {
      var local2:BattleBonusData = BattleBonusData(getData(BattleBonusData));
      var local3:BattleBonus = BattleBonus(battleService.getObjectPool().getObject(BattleBonus));
      local3.init(object.id,param1,local2,battleService);
      return local3;
    }
  }
}
