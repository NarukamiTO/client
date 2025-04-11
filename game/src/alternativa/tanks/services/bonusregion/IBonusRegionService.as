package alternativa.tanks.services.bonusregion {
  import alternativa.tanks.battle.objects.tank.Tank;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionResource;

  public interface IBonusRegionService {
    function prepare(param1:Vector.<BonusRegionResource>) : void;
    function showAll() : void;
    function destroy() : void;
    function addFewRegions(param1:Vector.<BonusRegionData>) : void;
    function addOneRegion(param1:BonusRegionData) : void;
    function setTank(param1:Tank) : void;
    function changeTank(param1:Tank) : void;
    function enableForceShow() : void;
    function enableForceHide() : void;
    function addAndShowRegion(param1:BonusRegionData) : void;
    function hideAndRemoveRegion(param1:BonusRegionData) : void;
    function hasRegion(param1:BonusRegionData) : Boolean;
    function toggleRegionsVisible() : void;
    function resetTank() : void;
  }
}
