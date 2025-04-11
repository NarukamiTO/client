package alternativa.types {
  public class URL {
    public var scheme:String;
    public var host:String;
    public var port:String;
    public var path:String;
    public var query:String;
    public var fragment:String;

    public function URL(param1:String, param2:Boolean = false) {
      super();
      var local3:int = int(param1.indexOf(":"));
      this.scheme = param1.substring(0,local3);
      if(param2) {
        this.scheme = "http";
      }
      param1 = param1.substring(local3 + 3);
      local3 = int(param1.indexOf("/"));
      var local4:String = param1.substring(0,local3);
      var local5:int = int(local4.indexOf(":"));
      if(local5 < 0) {
        this.host = local4;
      } else {
        this.host = local4.substring(0,local5);
        this.port = local4.substring(local5 + 1);
      }
      param1 = param1.substring(local3);
      var local6:int = int(param1.indexOf("?"));
      var local7:int = int(param1.indexOf("#"));
      if(local6 > -1) {
        this.path = param1.substring(0,local6);
        if(local7 > -1) {
          this.query = param1.substring(local6 + 1,local7);
          this.fragment = param1.substring(local7 + 1);
        } else {
          this.query = param1.substring(local6 + 1);
        }
      } else if(local7 > -1) {
        this.path = param1.substring(0,local7);
        this.fragment = param1.substring(local7 + 1);
      } else {
        this.path = param1;
      }
    }

    public function getRoot() : String {
      var local1:String = this.scheme + "://" + this.host;
      if(this.port == null) {
        return local1;
      }
      return local1 + ":" + this.port;
    }

    public function toString() : String {
      return "scheme: " + this.scheme + "\n" + "host: " + this.host + "\n" + "port: " + this.port + "\n" + "path: " + this.path + "\n" + "query: " + this.query + "\n" + "fragment: " + this.fragment;
    }
  }
}
