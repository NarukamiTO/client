package alternativa.tanks.model.mobilelootbox {
  import projects.tanks.client.garage.models.item.mobilelootbox.lootbox.IMobileLootBoxModelBase;
  import projects.tanks.client.garage.models.item.mobilelootbox.lootbox.MobileLoot;
  import projects.tanks.client.garage.models.item.mobilelootbox.lootbox.MobileLootBoxModelBase;

  [ModelInfo]
  public class MobileLootBoxModel extends MobileLootBoxModelBase implements IMobileLootBoxModelBase {
    public function MobileLootBoxModel() {
      super();
    }

    public function openSuccessful(param1:Vector.<MobileLoot>) : void {
    }

    public function openingFailed() : void {
    }

    public function updateCount(param1:int) : void {
    }
  }
}
