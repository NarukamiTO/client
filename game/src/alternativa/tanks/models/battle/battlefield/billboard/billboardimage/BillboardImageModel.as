package alternativa.tanks.models.battle.battlefield.billboard.billboardimage {
  import alternativa.tanks.battle.BattleService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battlefield.models.battle.battlefield.billboard.billboardimage.BillboardImageModelBase;
  import projects.tanks.client.battlefield.models.battle.battlefield.billboard.billboardimage.IBillboardImageModelBase;

  [ModelInfo]
  public class BillboardImageModel extends BillboardImageModelBase implements IBillboardImageModelBase, ObjectLoadListener {
    [Inject]
    public static var battleService:BattleService;

    public function BillboardImageModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      battleService.setBillboardImage(getInitParam().image.data);
    }
  }
}
