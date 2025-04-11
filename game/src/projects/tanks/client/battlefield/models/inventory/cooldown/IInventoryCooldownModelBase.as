package projects.tanks.client.battlefield.models.inventory.cooldown {
  public interface IInventoryCooldownModelBase {
    function activateCooldown(param1:int) : void;
    function activateDependentCooldown(param1:Vector.<DependedCooldownItem>) : void;
    function ready() : void;
    function setCooldownDuration(param1:int) : void;
  }
}
