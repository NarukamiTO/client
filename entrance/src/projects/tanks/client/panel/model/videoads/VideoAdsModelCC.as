package projects.tanks.client.panel.model.videoads {
  public class VideoAdsModelCC {
    private var _enable:Boolean;

    public function VideoAdsModelCC(param1:Boolean = false) {
      super();
      this._enable = param1;
    }

    public function get enable() : Boolean {
      return this._enable;
    }

    public function set enable(param1:Boolean) : void {
      this._enable = param1;
    }

    public function toString() : String {
      var local1:String = "VideoAdsModelCC [";
      local1 += "enable = " + this.enable + " ";
      return local1 + "]";
    }
  }
}
