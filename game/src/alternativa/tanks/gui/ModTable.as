package alternativa.tanks.gui {
  import controls.base.LabelBase;
  import flash.display.BitmapData;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.geom.Matrix;

  public class ModTable extends Sprite {
    private static const upgradeSelectionLeftClass:Class = ModTable_upgradeSelectionLeftClass;
    private static const upgradeSelectionCenterClass:Class = ModTable_upgradeSelectionCenterClass;

    private var _maxCostWidth:int;

    public var constWidth:int;
    public var rows:Vector.<ModInfoRow>;

    public const vSpace:int = 0;

    private var selection:Shape;
    private var selectedRowIndex:int = -1;
    private var _width:int;

    public function ModTable(param1:int) {
      var local3:ModInfoRow = null;
      this.rows = new Vector.<ModInfoRow>();
      super();
      this._width = param1;
      this.selection = new Shape();
      addChild(this.selection);
      this.selection.x = 3;
      var local2:int = 0;
      while(local2 < 4) {
        local3 = new ModInfoRow(local2,this._width);
        addChild(local3);
        local3.y = (local3.h + this.vSpace) * local2;
        this.rows.push(local3);
        local2++;
      }
      this.resizeSelection(this._width);
    }

    public function select(param1:int) : void {
      var local2:ModInfoRow = null;
      if(this.selectedRowIndex != -1) {
        local2 = this.rows[this.selectedRowIndex];
        local2.unselect();
      }
      this.selectedRowIndex = param1;
      this.selection.y = (ModInfoRow(this.rows[0]).h + this.vSpace) * param1;
      this.selection.visible = true;
      local2 = this.rows[this.selectedRowIndex];
      local2.select();
    }

    public function resetSelection() : void {
      var local1:ModInfoRow = null;
      this.selection.visible = false;
      if(this.selectedRowIndex != -1) {
        local1 = this.rows[this.selectedRowIndex];
        local1.unselect();
      }
      this.selectedRowIndex = -1;
    }

    private function resizeSelection(param1:int) : void {
      var local2:int = param1 - 6;
      var local3:BitmapData = new upgradeSelectionLeftClass().bitmapData;
      this.selection.graphics.clear();
      this.selection.graphics.beginBitmapFill(local3);
      this.selection.graphics.drawRect(0,0,local3.width,local3.height);
      var local4:BitmapData = new upgradeSelectionCenterClass().bitmapData;
      this.selection.graphics.beginBitmapFill(local4);
      this.selection.graphics.drawRect(local3.width,0,local2 - local3.width * 2,local4.height);
      var local5:Matrix = new Matrix(-1,0,0,1,local2,0);
      this.selection.graphics.beginBitmapFill(local3,local5);
      this.selection.graphics.drawRect(local2 - local3.width,0,local3.width,local3.height);
      this.selection.graphics.endFill();
    }

    public function correctNonintegralValues() : void {
      var local5:int = 0;
      var local6:LabelBase = null;
      var local7:int = 0;
      var local1:Array = new Array();
      var local2:ModInfoRow = this.rows[0];
      var local3:int = int(local2.labels.length);
      var local4:int = 0;
      while(local4 < 4) {
        local2 = this.rows[local4] as ModInfoRow;
        local5 = 0;
        while(local5 < local3) {
          local6 = local2.labels[local5] as LabelBase;
          if(local6.text.indexOf(".") != -1) {
            local1.push(local5);
          }
          local5++;
        }
        local4++;
      }
      local4 = 0;
      while(local4 < 4) {
        local2 = this.rows[local4];
        local5 = 0;
        while(local5 < local1.length) {
          local7 = int(local1[local5]);
          local6 = local2.labels[local7] as LabelBase;
          if(local6.text.indexOf(".") == -1) {
            local6.text += ".0";
          }
          local5++;
        }
        local4++;
      }
    }

    public function set maxCostWidth(param1:int) : void {
      this._maxCostWidth = param1;
      var local2:ModInfoRow = this.rows[0];
      this.constWidth = local2.upgradeIndicator.width + local2.rankIcon.width + 3 + local2.crystalIcon.width + this._maxCostWidth + local2.hSpace * 3;
      var local3:int = 0;
      while(local3 < 4) {
        local2 = this.rows[local3] as ModInfoRow;
        local2.costWidth = this._maxCostWidth;
        local3++;
      }
    }
  }
}
