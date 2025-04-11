package alternativa.tanks.bonuses {
  import platform.client.fp10.core.type.AutoClosable;

  public class ObjectCache {
    private var size:int;
    private var objects:Vector.<Object> = new Vector.<Object>();

    public function ObjectCache() {
      super();
    }

    public function put(param1:Object) : void {
      var local2:* = this.size++;
      this.objects[local2] = param1;
    }

    public function get() : Object {
      if(this.isEmpty()) {
        throw new Error();
      }
      --this.size;
      var local1:Object = this.objects[this.size];
      this.objects[this.size] = null;
      return local1;
    }

    public function isEmpty() : Boolean {
      return this.size == 0;
    }

    public function clear() : void {
      var local1:Object = null;
      for each(local1 in this.objects) {
        if(local1 is AutoClosable) {
          AutoClosable(local1).close();
        }
      }
      this.objects.length = 0;
      this.size = 0;
    }
  }
}
