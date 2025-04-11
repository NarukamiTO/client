package projects.tanks.client.panel.model.donationalert {
  import platform.client.fp10.core.resource.types.LocalizedImageResource;

  public class DonationAlertCC {
    private var _imageWithEmail:LocalizedImageResource;
    private var _imageWithoutEmail:LocalizedImageResource;
    private var _message:String;

    public function DonationAlertCC(param1:LocalizedImageResource = null, param2:LocalizedImageResource = null, param3:String = null) {
      super();
      this._imageWithEmail = param1;
      this._imageWithoutEmail = param2;
      this._message = param3;
    }

    public function get imageWithEmail() : LocalizedImageResource {
      return this._imageWithEmail;
    }

    public function set imageWithEmail(param1:LocalizedImageResource) : void {
      this._imageWithEmail = param1;
    }

    public function get imageWithoutEmail() : LocalizedImageResource {
      return this._imageWithoutEmail;
    }

    public function set imageWithoutEmail(param1:LocalizedImageResource) : void {
      this._imageWithoutEmail = param1;
    }

    public function get message() : String {
      return this._message;
    }

    public function set message(param1:String) : void {
      this._message = param1;
    }

    public function toString() : String {
      var local1:String = "DonationAlertCC [";
      local1 += "imageWithEmail = " + this.imageWithEmail + " ";
      local1 += "imageWithoutEmail = " + this.imageWithoutEmail + " ";
      local1 += "message = " + this.message + " ";
      return local1 + "]";
    }
  }
}
