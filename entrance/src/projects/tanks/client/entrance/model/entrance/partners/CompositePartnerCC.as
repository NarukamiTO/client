package projects.tanks.client.entrance.model.entrance.partners {
  public class CompositePartnerCC {
    private var _forceSocialNetwork:String;

    public function CompositePartnerCC(param1:String = null) {
      super();
      this._forceSocialNetwork = param1;
    }

    public function get forceSocialNetwork() : String {
      return this._forceSocialNetwork;
    }

    public function set forceSocialNetwork(param1:String) : void {
      this._forceSocialNetwork = param1;
    }

    public function toString() : String {
      var local1:String = "CompositePartnerCC [";
      local1 += "forceSocialNetwork = " + this.forceSocialNetwork + " ";
      return local1 + "]";
    }
  }
}
