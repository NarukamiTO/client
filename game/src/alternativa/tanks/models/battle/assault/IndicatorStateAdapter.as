package alternativa.tanks.models.battle.assault {
  import alternativa.math.Vector3;
  import alternativa.tanks.models.battle.gui.markers.PointIndicatorStateProvider;

  public class IndicatorStateAdapter implements PointIndicatorStateProvider {
    private var position:Vector3;
    private var zAscention:Number;

    public function IndicatorStateAdapter(param1:Vector3, param2:Number = 350) {
      super();
      this.position = param1;
      this.zAscention = param2;
    }

    public function getIndicatorPosition() : Vector3 {
      return this.position;
    }

    public function isIndicatorActive(param1:Vector3 = null) : Boolean {
      return true;
    }

    public function zOffset() : Number {
      return this.zAscention;
    }
  }
}
