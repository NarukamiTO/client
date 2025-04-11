package alternativa.tanks.view.battleinfo.renderer {
  import controls.cellrenderer.ButtonState;

  public class BattleInfoRedUserListRenderer extends BattleInfoUserListRenderer {
    private var style:ButtonState = new CellRed();

    public function BattleInfoRedUserListRenderer() {
      super();
    }

    override public function getCurrentStyle() : ButtonState {
      return this.style;
    }
  }
}
