package alternativa.tanks.view.battlelist.forms {
  import alternativa.tanks.view.battlelist.battleitem.renderer.full.CellRendererFullUp;
  import alternativa.tanks.view.battlelist.battleitem.renderer.full.CellRendererFullUpSelected;
  import alternativa.tanks.view.battlelist.battleitem.renderer.normal.CellNormalSelected;
  import alternativa.tanks.view.battlelist.battleitem.renderer.unavailable.CellUnavailableSelected;
  import controls.cellrenderer.CellNormal;
  import controls.cellrenderer.CellUnavailable;
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ListData;
  import flash.display.DisplayObject;

  public class BattleListRenderer extends CellRenderer {
    private var access:Boolean = true;
    private var nicon:DisplayObject;
    private var sicon:DisplayObject;
    private var isFull:Boolean;

    public function BattleListRenderer() {
      super();
    }

    override public function set data(param1:Object) : void {
      _data = param1;
      this.access = param1.accessible;
      this.nicon = param1.iconNormal;
      this.sicon = param1.iconSelected;
      this.isFull = param1.isFull;
      this.setupBackgroundStyles();
    }

    override public function set listData(param1:ListData) : void {
      _listData = param1;
      label = _listData.label;
      if(this.nicon != null && this.sicon != null) {
        setStyle("icon",this.nicon);
        setStyle("selectedUpIcon",this.sicon);
        setStyle("selectedOverIcon",this.sicon);
        setStyle("selectedDownIcon",this.sicon);
      }
    }

    override protected function drawBackground() : void {
      var local1:String = enabled ? mouseState : "disabled";
      if(selected) {
        local1 = "selected" + local1.substr(0,1).toUpperCase() + local1.substr(1);
      }
      local1 += "Skin";
      var local2:DisplayObject = background;
      background = getDisplayObjectInstance(getStyleValue(local1));
      addChildAt(background,0);
      if(local2 != null && local2 != background) {
        removeChild(local2);
      }
    }

    override protected function drawLayout() : void {
      super.drawLayout();
      background.width = width - 4;
      background.height = height;
    }

    override protected function drawIcon() : void {
      var local1:DisplayObject = icon;
      var local2:String = enabled ? mouseState : "disabled";
      if(selected) {
        local2 = "selected" + local2.substr(0,1).toUpperCase() + local2.substr(1);
      }
      local2 += "Icon";
      var local3:Object = getStyleValue(local2);
      if(local3 == null) {
        local3 = getStyleValue("icon");
      }
      if(local3 != null) {
        icon = getDisplayObjectInstance(local3);
      }
      if(icon != null) {
        addChildAt(icon,1);
      }
      if(local1 != null && local1 != icon && local1.parent == this) {
        removeChild(local1);
      }
    }

    private function setupBackgroundStyles() : void {
      if(this.access) {
        if(this.isFull) {
          setStyle("upSkin",CellRendererFullUp);
          setStyle("overSkin",CellRendererFullUp);
          setStyle("downSkin",CellRendererFullUp);
          setStyle("selectedUpSkin",CellRendererFullUpSelected);
          setStyle("selectedOverSkin",CellRendererFullUpSelected);
          setStyle("selectedDownSkin",CellRendererFullUpSelected);
        } else {
          setStyle("upSkin",CellNormal);
          setStyle("overSkin",CellNormal);
          setStyle("downSkin",CellNormal);
          setStyle("selectedUpSkin",CellNormalSelected);
          setStyle("selectedOverSkin",CellNormalSelected);
          setStyle("selectedDownSkin",CellNormalSelected);
        }
      } else {
        setStyle("upSkin",CellUnavailable);
        setStyle("overSkin",CellUnavailable);
        setStyle("downSkin",CellUnavailable);
        setStyle("selectedUpSkin",CellUnavailableSelected);
        setStyle("selectedOverSkin",CellUnavailableSelected);
        setStyle("selectedDownSkin",CellUnavailableSelected);
      }
    }
  }
}
