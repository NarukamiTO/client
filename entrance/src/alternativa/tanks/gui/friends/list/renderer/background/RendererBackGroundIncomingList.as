package alternativa.tanks.gui.friends.list.renderer.background {
  import controls.cellrenderer.ButtonState;
  import flash.display.DisplayObject;
  import flash.display.Sprite;

  public class RendererBackGroundIncomingList extends Sprite {
    private var _width:int = 100;

    public function RendererBackGroundIncomingList(param1:Boolean) {
      var local2:ButtonState = null;
      super();
      if(param1) {
        local2 = new FriendCellSelected();
      } else {
        local2 = new FriendCellNormal();
      }
      addChild(local2);
      this.resize();
    }

    protected function resize() : void {
      var local1:DisplayObject = getChildAt(0);
      local1.width = this._width - 3;
      local1.height = 18;
    }

    override public function set width(param1:Number) : void {
      this._width = Math.floor(param1);
      this.resize();
    }
  }
}
