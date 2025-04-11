package projects.tanks.client.panel.model.challenge.stars {
  public class StarsInfoCC {
    private var _stars:int;

    public function StarsInfoCC(param1:int = 0) {
      super();
      this._stars = param1;
    }

    public function get stars() : int {
      return this._stars;
    }

    public function set stars(param1:int) : void {
      this._stars = param1;
    }

    public function toString() : String {
      var local1:String = "StarsInfoCC [";
      local1 += "stars = " + this.stars + " ";
      return local1 + "]";
    }
  }
}
