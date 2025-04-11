package alternativa.utils {
  public class Properties {
    private var data:Object;

    public function Properties(param1:Object = null) {
      super();
      this.data = param1 || {};
    }

    public function getProperty(param1:String) : String {
      return this.data[param1];
    }

    public function getPropertyDef(param1:String, param2:String) : String {
      return this.data[param1] || param2;
    }

    public function setProperty(param1:String, param2:String) : void {
      if(!param2) {
        throw new ArgumentError("Empty values are not allowed");
      }
      this.data[param1] = param2;
    }

    public function removeProperty(param1:String) : void {
      delete this.data[param1];
    }

    public function get propertyNames() : Vector.<String> {
      var local2:String = null;
      var local1:Vector.<String> = new Vector.<String>();
      for(local2 in this.data) {
        local1.push(local2);
      }
      return local1;
    }

    public function toString() : String {
      var local2:String = null;
      var local1:* = "";
      for(local2 in this.data) {
        if(local1) {
          local1 += ", ";
        }
        local1 += local2 + ": " + this.data[local2];
      }
      return "[Properties " + local1 + "]";
    }
  }
}
