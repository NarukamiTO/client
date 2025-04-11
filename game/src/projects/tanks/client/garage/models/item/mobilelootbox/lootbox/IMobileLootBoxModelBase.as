package projects.tanks.client.garage.models.item.mobilelootbox.lootbox {
  public interface IMobileLootBoxModelBase {
    function openSuccessful(param1:Vector.<MobileLoot>) : void;
    function openingFailed() : void;
    function updateCount(param1:int) : void;
  }
}
