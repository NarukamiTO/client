package alternativa.tanks.view.battleinfo.renderer {
  import controls.cellrenderer.ButtonState;

  public class BattleInfoBlueUserListRenderer extends BattleInfoUserListRenderer {
    private var style:ButtonState = new CellBlue();

    public function BattleInfoBlueUserListRenderer() {
      super();
    }

    override public function getCurrentStyle() : ButtonState {
      return this.style;
    }
  }
}
