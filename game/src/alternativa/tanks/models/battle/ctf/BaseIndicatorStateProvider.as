package alternativa.tanks.models.battle.ctf {
  import alternativa.math.Vector3;
  import alternativa.tanks.models.battle.gui.markers.PointHudIndicator;
  import alternativa.tanks.models.battle.gui.markers.PointIndicatorStateProvider;
  import alternativa.tanks.models.controlpoints.hud.KeyPointView;

  public class BaseIndicatorStateProvider implements PointIndicatorStateProvider {
    private var position:Vector3;
    private var associatedIndicator:PointHudIndicator;

    public function BaseIndicatorStateProvider(param1:Vector3, param2:PointHudIndicator) {
      super();
      this.position = param1;
      this.associatedIndicator = param2;
    }

    public function getIndicatorPosition() : Vector3 {
      return this.position;
    }

    public function isIndicatorActive(param1:Vector3 = null) : Boolean {
      return this.associatedIndicator.getState() != PointHudIndicator.STATE_DEFAULT;
    }

    public function zOffset() : Number {
      return KeyPointView.CIRCLE_ASCENSION;
    }
  }
}
