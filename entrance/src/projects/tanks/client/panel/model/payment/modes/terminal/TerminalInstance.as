package projects.tanks.client.panel.model.payment.modes.terminal {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class TerminalInstance {
    private var _image:ImageResource;
    private var _url:String;

    public function TerminalInstance(param1:ImageResource = null, param2:String = null) {
      super();
      this._image = param1;
      this._url = param2;
    }

    public function get image() : ImageResource {
      return this._image;
    }

    public function set image(param1:ImageResource) : void {
      this._image = param1;
    }

    public function get url() : String {
      return this._url;
    }

    public function set url(param1:String) : void {
      this._url = param1;
    }

    public function toString() : String {
      var local1:String = "TerminalInstance [";
      local1 += "image = " + this.image + " ";
      local1 += "url = " + this.url + " ";
      return local1 + "]";
    }
  }
}
