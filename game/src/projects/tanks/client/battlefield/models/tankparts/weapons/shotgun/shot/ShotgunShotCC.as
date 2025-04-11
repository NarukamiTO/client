package projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.shot {
  public class ShotgunShotCC {
    private var _magazineReloadTime:int;
    private var _magazineSize:int;

    public function ShotgunShotCC(param1:int = 0, param2:int = 0) {
      super();
      this._magazineReloadTime = param1;
      this._magazineSize = param2;
    }

    public function get magazineReloadTime() : int {
      return this._magazineReloadTime;
    }

    public function set magazineReloadTime(param1:int) : void {
      this._magazineReloadTime = param1;
    }

    public function get magazineSize() : int {
      return this._magazineSize;
    }

    public function set magazineSize(param1:int) : void {
      this._magazineSize = param1;
    }

    public function toString() : String {
      var local1:String = "ShotgunShotCC [";
      local1 += "magazineReloadTime = " + this.magazineReloadTime + " ";
      local1 += "magazineSize = " + this.magazineSize + " ";
      return local1 + "]";
    }
  }
}
