package alternativa.tanks.gui.settings.controls {
  import flash.display.DisplayObject;

  public class GridLayout {
    private var topX:int;
    private var topY:int;
    private var columnWidth:int;
    private var rowHeight:int;
    private var rowMargin:int;

    public function GridLayout(param1:int, param2:int, param3:int, param4:int) {
      super();
      this.topX = param1;
      this.topY = param2;
      this.columnWidth = param3;
      this.rowHeight = param4;
    }

    public function layout(param1:Array) : int {
      var local2:int = 0;
      var local4:Array = null;
      var local5:int = 0;
      var local6:DisplayObject = null;
      var local3:int = 0;
      while(local3 < param1.length) {
        local4 = param1[local3];
        local5 = 0;
        while(local5 < local4.length) {
          if(local4[local5] != null) {
            local6 = local4[local5];
            local6.x = this.topX + local5 * this.columnWidth;
            local6.y = this.topY + local3 * this.rowHeight + this.rowMargin * local3;
            local2 = local6.y + local6.height;
          }
          local5++;
        }
        local3++;
      }
      return local2;
    }

    public function getRowMargin() : int {
      return this.rowMargin;
    }

    public function setRowMargin(param1:int) : void {
      this.rowMargin = param1;
    }
  }
}
