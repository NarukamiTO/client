package alternativa.tanks.utils.objectpool {
  public class Pool {
    private var numObjects:int;
    private var objectClass:Class;
    private var objects:Vector.<Object> = new Vector.<Object>();

    public function Pool(param1:Class) {
      super();
      this.objectClass = param1;
    }

    final public function getNumObjects() : int {
      return this.numObjects;
    }

    final public function getObject() : Object {
      if(this.numObjects == 0) {
        return new this.objectClass(this);
      }
      var local1:Object = this.objects[--this.numObjects];
      this.objects[this.numObjects] = null;
      return local1;
    }

    final public function putObject(param1:Object) : void {
      if(this.objectClass != param1.constructor) {
        throw new ArgumentError();
      }
      var local2:* = this.numObjects++;
      this.objects[local2] = param1;
    }

    final public function clear() : void {
      this.objects.length = 0;
      this.numObjects = 0;
    }
  }
}
