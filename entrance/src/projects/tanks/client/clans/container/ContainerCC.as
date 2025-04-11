package projects.tanks.client.clans.container {
  import alternativa.types.Long;

  public class ContainerCC {
    private var _objects:Vector.<Long>;

    public function ContainerCC(param1:Vector.<Long> = null) {
      super();
      this._objects = param1;
    }

    public function get objects() : Vector.<Long> {
      return this._objects;
    }

    public function set objects(param1:Vector.<Long>) : void {
      this._objects = param1;
    }

    public function toString() : String {
      var local1:String = "ContainerCC [";
      local1 += "objects = " + this.objects + " ";
      return local1 + "]";
    }
  }
}
