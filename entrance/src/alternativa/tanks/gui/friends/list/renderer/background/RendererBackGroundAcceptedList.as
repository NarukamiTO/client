package alternativa.tanks.gui.friends.list.renderer.background {
  import alternativa.tanks.gui.friends.list.AcceptedList;
  import alternativa.tanks.gui.friends.list.renderer.HeaderAcceptedList;
  import controls.cellrenderer.ButtonState;
  import flash.display.Sprite;

  public class RendererBackGroundAcceptedList extends Sprite {
    protected var tabs:Vector.<Number>;
    protected var _width:int = 100;

    public function RendererBackGroundAcceptedList(param1:Boolean, param2:Boolean = false) {
      var local3:ButtonState = null;
      this.tabs = new Vector.<Number>();
      super();
      var local4:int = int(HeaderAcceptedList.HEADERS.length);
      var local5:int = 0;
      while(local5 < local4) {
        if(param1) {
          if(param2) {
            local3 = new FriendCellSelected();
          } else {
            local3 = new FriendCellNormal();
          }
        } else if(param2) {
          local3 = new UserOfflineCellSelected();
        } else {
          local3 = new UserOfflineCellNormal();
        }
        addChild(local3);
        local5++;
      }
      this.resize();
    }

    protected function resize() : void {
      var local1:ButtonState = null;
      if(this.isScroll()) {
        this.tabs = Vector.<Number>([0,this._width - 224,this._width - 1]);
      } else {
        this.tabs = Vector.<Number>([0,this._width - 233,this._width - 1]);
      }
      var local2:int = int(HeaderAcceptedList.HEADERS.length);
      var local3:int = 0;
      while(local3 < local2) {
        local1 = getChildAt(local3) as ButtonState;
        local1.width = this.tabs[local3 + 1] - this.tabs[local3] - 2;
        local1.height = 18;
        local1.x = this.tabs[local3];
        local3++;
      }
      graphics.clear();
      graphics.beginFill(16711680,0);
      graphics.drawRect(0,0,this._width - 1,18);
      graphics.endFill();
    }

    protected function isScroll() : Boolean {
      return AcceptedList.SCROLL_ON;
    }

    override public function set width(param1:Number) : void {
      this._width = Math.floor(param1);
      this.resize();
    }
  }
}
