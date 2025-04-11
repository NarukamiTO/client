package projects.tanks.client.garage.models.item.container.weekly {
  import projects.tanks.client.garage.models.item.container.ContainerGivenItem;

  public interface IWeeklyContainerModelBase {
    function openSuccessful(param1:Vector.<ContainerGivenItem>) : void;
    function updateCount(param1:int) : void;
  }
}
