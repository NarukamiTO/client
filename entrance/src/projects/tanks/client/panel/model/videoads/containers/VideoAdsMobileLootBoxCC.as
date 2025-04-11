package projects.tanks.client.panel.model.videoads.containers {
  public class VideoAdsMobileLootBoxCC {
    private var _adsAvailable:Boolean;

    public function VideoAdsMobileLootBoxCC(param1:Boolean = false) {
      super();
      this._adsAvailable = param1;
    }

    public function get adsAvailable() : Boolean {
      return this._adsAvailable;
    }

    public function set adsAvailable(param1:Boolean) : void {
      this._adsAvailable = param1;
    }

    public function toString() : String {
      var local1:String = "VideoAdsMobileLootBoxCC [";
      local1 += "adsAvailable = " + this.adsAvailable + " ";
      return local1 + "]";
    }
  }
}
