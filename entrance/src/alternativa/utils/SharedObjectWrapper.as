package alternativa.utils {
  import flash.net.SharedObject;

  public class SharedObjectWrapper {
    private var object:SharedObject;
    private var data:Object;

    public function SharedObjectWrapper(param1:SharedObject) {
      super();
      if(param1 == null) {
        throw new Error("Parameter object is null");
      }
      this.object = param1;
      this.data = param1.data;
    }

    public function flush(param1:int = 0) : String {
      return this.object.flush(param1);
    }

    public function setData(param1:String, param2:*) : void {
      this.data[param1] = param2;
    }

    public function deleteData(param1:String) : void {
      delete this.data[param1];
    }

    public function getString(param1:String, param2:String) : String {
      return this.data[param1] == null ? param2 : this.data[param1];
    }

    public function getInt(param1:String, param2:int) : int {
      return this.data[param1] == null ? param2 : int(this.data[param1]);
    }

    public function getNumber(param1:String, param2:Number) : Number {
      return this.data[param1] == null ? param2 : Number(this.data[param1]);
    }

    public function getBoolean(param1:String, param2:Boolean) : Boolean {
      if(this.data[param1] === undefined) {
        return param2;
      }
      return this.data[param1];
    }

    public function getObject(param1:String, param2:Object) : Object {
      return this.data[param1] == null ? param2 : this.data[param1];
    }
  }
}
