package projects.tanks.client.garage.models.item.object3ds {
  import alternativa.types.Long;

  public class Object3DSCC {
    private var _resourceId:Long;

    public function Object3DSCC(param1:Long = null) {
      super();
      this._resourceId = param1;
    }

    public function get resourceId() : Long {
      return this._resourceId;
    }

    public function set resourceId(param1:Long) : void {
      this._resourceId = param1;
    }

    public function toString() : String {
      var local1:String = "Object3DSCC [";
      local1 += "resourceId = " + this.resourceId + " ";
      return local1 + "]";
    }
  }
}
