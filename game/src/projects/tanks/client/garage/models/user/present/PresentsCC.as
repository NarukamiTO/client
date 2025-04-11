package projects.tanks.client.garage.models.user.present {
  public class PresentsCC {
    private var _presents:Vector.<PresentItem>;

    public function PresentsCC(param1:Vector.<PresentItem> = null) {
      super();
      this._presents = param1;
    }

    public function get presents() : Vector.<PresentItem> {
      return this._presents;
    }

    public function set presents(param1:Vector.<PresentItem>) : void {
      this._presents = param1;
    }

    public function toString() : String {
      var local1:String = "PresentsCC [";
      local1 += "presents = " + this.presents + " ";
      return local1 + "]";
    }
  }
}
