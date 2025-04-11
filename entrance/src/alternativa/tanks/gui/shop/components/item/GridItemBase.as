package alternativa.tanks.gui.shop.components.item {
  import base.DiscreteSprite;

  public class GridItemBase extends DiscreteSprite {
    public function GridItemBase() {
      super();
    }

    public function destroy() : void {
    }

    public function get widthInCells() : int {
      return 1;
    }

    public function get forceNewLine() : Boolean {
      return false;
    }
  }
}
