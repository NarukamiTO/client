package alternativa.tanks.models.battle.gui.markers {
  import alternativa.math.Vector3;

  public interface PointIndicatorStateProvider {
    function getIndicatorPosition() : Vector3;
    function isIndicatorActive(param1:Vector3 = null) : Boolean;
    function zOffset() : Number;
  }
}
