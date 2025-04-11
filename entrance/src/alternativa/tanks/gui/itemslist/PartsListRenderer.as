package alternativa.tanks.gui.itemslist {
  import alternativa.osgi.service.clientlog.IClientLog;
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ListData;
  import flash.display.DisplayObject;
  import platform.client.fp10.core.resource.IResourceLoadingListener;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.types.ImageResource;

  public class PartsListRenderer extends CellRenderer implements IResourceLoadingListener {
    [Inject]
    public static var clientLog:IClientLog;

    private static var defaultStyles:Object = {
      "upSkin":null,
      "downSkin":null,
      "overSkin":null,
      "disabledSkin":null,
      "selectedDisabledSkin":null,
      "selectedUpSkin":null,
      "selectedDownSkin":null,
      "selectedOverSkin":null,
      "textFormat":null,
      "disabledTextFormat":null,
      "embedFonts":null,
      "textPadding":5
    };

    private var nicon:DisplayObject;
    private var sicon:DisplayObject;

    public function PartsListRenderer() {
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
      var local2:ImageResource = _data.dat.preview as ImageResource;
      if(local2 != null) {
        if(local2.data == null) {
          local2.loadLazyResource(this);
        }
      }
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
    }

    override protected function drawLayout() : void {
    }

    override protected function drawIcon() : void {
      var local2:String = null;
      var local1:DisplayObject = icon;
      local2 = enabled ? mouseState : "disabled";
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

    public function onResourceLoadingStart(param1:Resource) : void {
    }

    public function onResourceLoadingProgress(param1:Resource, param2:int) : void {
    }

    public function onResourceLoadingComplete(param1:Resource) : void {
    }

    public function onResourceLoadingError(param1:Resource, param2:String) : void {
    }

    public function onResourceLoadingFatalError(param1:Resource, param2:String) : void {
    }
  }
}
