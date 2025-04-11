package alternativa.tanks.utils.objectpool {
  import flash.utils.Dictionary;

  public class ObjectPool {
    private var pools:Dictionary = new Dictionary();

    public function ObjectPool() {
      super();
    }

    public function getObject(param1:Class) : Object {
      return this.getPoolForClass(param1).getObject();
    }

    public function clear() : void {
      var local1:* = undefined;
      for(local1 in this.pools) {
        Pool(this.pools[local1]).clear();
        delete this.pools[local1];
      }
    }

    public function clearPoolForClass(param1:Class) : void {
      var local2:Pool = this.pools[param1];
      if(local2 != null) {
        local2.clear();
      }
    }

    [Obfuscation(rename="false")]
    public function toString() : String {
      var local2:* = undefined;
      var local3:Pool = null;
      var local1:String = "";
      for(local2 in this.pools) {
        local3 = this.pools[local2];
        local1 += local2 + ": " + local3.getNumObjects() + "\n";
      }
      return local1;
    }

    private function getPoolForClass(param1:Class) : Pool {
      var local2:Pool = this.pools[param1];
      if(local2 == null) {
        local2 = new Pool(param1);
        this.pools[param1] = local2;
      }
      return local2;
    }
  }
}
