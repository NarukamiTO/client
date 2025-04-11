package alternativa.tanks.view.mainview.grouplist.item {
  import alternativa.tanks.gui.friends.list.renderer.background.UserOfflineCellNormal;
  import alternativa.tanks.gui.friends.list.renderer.background.UserOfflineCellSelected;
  import controls.cellrenderer.ButtonState;
  import controls.cellrenderer.CellNormal;
  import controls.cellrenderer.CellNormalSelected;
  import flash.display.Sprite;

  public class GroupUserCellStyle extends Sprite {
    protected var _width:int = 100;

    private var background:ButtonState;

    public function GroupUserCellStyle(param1:Boolean, param2:Boolean) {
      super();
      if(param2) {
        this.background = param1 ? new CellNormalSelected() : new UserOfflineCellSelected();
      } else {
        this.background = param1 ? new CellNormal() : new UserOfflineCellNormal();
      }
      addChild(this.background);
      this.resize();
    }

    private function resize() : void {
      this.background.width = this._width;
    }

    override public function set width(param1:Number) : void {
      this._width = Math.floor(param1);
      this.resize();
    }
  }
}
