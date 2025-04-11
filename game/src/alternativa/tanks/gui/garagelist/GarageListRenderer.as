package alternativa.tanks.gui.garagelist {
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ListData;
  import flash.display.DisplayObject;
  import platform.client.fp10.core.resource.types.ImageResource;
  import utils.preview.IImageResource;
  import utils.preview.ImageResourceLoadingWrapper;

  public class GarageListRenderer extends CellRenderer implements IImageResource {
    private var nicon:DisplayObject;
    private var sicon:DisplayObject;

    public function GarageListRenderer() {
      super();
      this.buttonMode = true;
      this.useHandCursor = true;
    }

    override public function set data(param1:Object) : void {
      _data = param1;
      this.nicon = param1.iconNormal;
      this.sicon = param1.iconSelected;
    }

    override public function set listData(param1:ListData) : void {
      this.loadLazyResource();
      _listData = param1;
      label = _listData.label;
      if(this.nicon != null && this.sicon != null) {
        setStyle("icon",this.nicon);
        setStyle("selectedUpIcon",this.sicon);
        setStyle("selectedOverIcon",this.sicon);
        setStyle("selectedDownIcon",this.sicon);
      }
    }

    private function loadLazyResource() : void {
      var local1:ImageResource = _data.preview as ImageResource;
      if(local1 != null && !local1.isLoaded) {
        local1.loadLazyResource(new ImageResourceLoadingWrapper(this));
      }
    }

    public function setPreviewResource(param1:ImageResource) : void {
    }

    override protected function drawBackground() : void {
    }

    override protected function drawLayout() : void {
    }

    override protected function drawIcon() : void {
      var local2:String = null;
      var local1:DisplayObject = icon;
      local2 = !!enabled ? mouseState : "disabled";
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
  }
}
