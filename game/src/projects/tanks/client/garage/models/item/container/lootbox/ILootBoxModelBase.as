package projects.tanks.client.garage.models.item.container.lootbox {
  import projects.tanks.client.garage.models.item.container.ContainerGivenItem;

  public interface ILootBoxModelBase {
    function openSuccessful(param1:Vector.<ContainerGivenItem>) : void;
    function updateCount(param1:int) : void;
  }
}
