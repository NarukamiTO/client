package alternativa.tanks.utils.thirdparty {
  public class URI {
    public static const URImustEscape:String = " %";
    public static const URIbaselineEscape:String = URImustEscape + ":?#/@";
    public static const URIpathEscape:String = URImustEscape + "?#";
    public static const URIqueryEscape:String = URImustEscape + "#";
    public static const URIqueryPartEscape:String = URImustEscape + "#&=";
    public static const URInonHierEscape:String = URImustEscape + "?#/";
    public static const UNKNOWN_SCHEME:String = "unknown";

    protected static const URIbaselineExcludedBitmap:URIEncodingBitmap = new URIEncodingBitmap(URIbaselineEscape);
    protected static const URIschemeExcludedBitmap:URIEncodingBitmap = URIbaselineExcludedBitmap;
    protected static const URIuserpassExcludedBitmap:URIEncodingBitmap = URIbaselineExcludedBitmap;
    protected static const URIauthorityExcludedBitmap:URIEncodingBitmap = URIbaselineExcludedBitmap;
    protected static const URIportExludedBitmap:URIEncodingBitmap = URIbaselineExcludedBitmap;
    protected static const URIpathExcludedBitmap:URIEncodingBitmap = new URIEncodingBitmap(URIpathEscape);
    protected static const URIqueryExcludedBitmap:URIEncodingBitmap = new URIEncodingBitmap(URIqueryEscape);
    protected static const URIqueryPartExcludedBitmap:URIEncodingBitmap = new URIEncodingBitmap(URIqueryPartEscape);
    protected static const URIfragmentExcludedBitmap:URIEncodingBitmap = URIqueryExcludedBitmap;
    protected static const URInonHierexcludedBitmap:URIEncodingBitmap = new URIEncodingBitmap(URInonHierEscape);

    public static const NOT_RELATED:int = 0;
    public static const CHILD:int = 1;
    public static const EQUAL:int = 2;
    public static const PARENT:int = 3;

    protected static var _resolver:IURIResolver = null;

    protected var _valid:Boolean = false;
    protected var _relative:Boolean = false;
    protected var _scheme:String = "";
    protected var _authority:String = "";
    protected var _username:String = "";
    protected var _password:String = "";
    protected var _port:String = "";
    protected var _path:String = "";
    protected var _query:String = "";
    protected var _fragment:String = "";
    protected var _nonHierarchical:String = "";

    public function URI(param1:String = null) {
      super();
      if(param1 == null) {
        this.initialize();
      } else {
        this.constructURI(param1);
      }
    }

    public static function escapeChars(param1:String) : String {
      return fastEscapeChars(param1,URI.URIbaselineExcludedBitmap);
    }

    public static function unescapeChars(param1:String) : String {
      var local2:String = null;
      return decodeURIComponent(param1);
    }

    public static function fastEscapeChars(param1:String, param2:URIEncodingBitmap) : String {
      var local4:String = null;
      var local5:int = 0;
      var local6:int = 0;
      var local3:String = "";
      local6 = 0;
      while(local6 < param1.length) {
        local4 = param1.charAt(local6);
        local5 = param2.ShouldEscape(local4);
        if(Boolean(local5)) {
          local4 = local5.toString(16);
          if(local4.length == 1) {
            local4 = "0" + local4;
          }
          local4 = "%" + local4;
          local4 = local4.toUpperCase();
        }
        local3 += local4;
        local6++;
      }
      return local3;
    }

    public static function queryPartEscape(param1:String) : String {
      var local2:String = param1;
      return URI.fastEscapeChars(param1,URI.URIqueryPartExcludedBitmap);
    }

    public static function queryPartUnescape(param1:String) : String {
      var local2:String = param1;
      return unescapeChars(local2);
    }

    protected static function compareStr(param1:String, param2:String, param3:Boolean = true) : Boolean {
      if(param3 == false) {
        param1 = param1.toLowerCase();
        param2 = param2.toLowerCase();
      }
      return param1 == param2;
    }

    protected static function resolve(param1:URI) : URI {
      var local2:URI = new URI();
      local2.copyURI(param1);
      if(_resolver != null) {
        return _resolver.resolve(local2);
      }
      return local2;
    }

    public static function set resolver(param1:IURIResolver) : void {
      _resolver = param1;
    }

    public static function get resolver() : IURIResolver {
      return _resolver;
    }

    protected function constructURI(param1:String) : Boolean {
      if(!this.parseURI(param1)) {
        this._valid = false;
      }
      return this.isValid();
    }

    protected function initialize() : void {
      this._valid = false;
      this._relative = false;
      this._scheme = UNKNOWN_SCHEME;
      this._authority = "";
      this._username = "";
      this._password = "";
      this._port = "";
      this._path = "";
      this._query = "";
      this._fragment = "";
      this._nonHierarchical = "";
    }

    protected function set hierState(param1:Boolean) : void {
      if(param1) {
        this._nonHierarchical = "";
        if(this._scheme == "" || this._scheme == UNKNOWN_SCHEME) {
          this._relative = true;
        } else {
          this._relative = false;
        }
        if(this._authority.length == 0 && this._path.length == 0) {
          this._valid = false;
        } else {
          this._valid = true;
        }
      } else {
        this._authority = "";
        this._username = "";
        this._password = "";
        this._port = "";
        this._path = "";
        this._relative = false;
        if(this._scheme == "" || this._scheme == UNKNOWN_SCHEME) {
          this._valid = false;
        } else {
          this._valid = true;
        }
      }
    }

    protected function get hierState() : Boolean {
      return this._nonHierarchical.length == 0;
    }

    protected function validateURI() : Boolean {
      if(this.isAbsolute()) {
        if(this._scheme.length <= 1 || this._scheme == UNKNOWN_SCHEME) {
          return false;
        }
        if(this.verifyAlpha(this._scheme) == false) {
          return false;
        }
      }
      if(this.hierState) {
        if(this._path.search("\\") != -1) {
          return false;
        }
        if(this.isRelative() == false && this._scheme == UNKNOWN_SCHEME) {
          return false;
        }
      } else if(this._nonHierarchical.search("\\") != -1) {
        return false;
      }
      return true;
    }

    protected function parseURI(param1:String) : Boolean {
      var local3:int = 0;
      var local4:int = 0;
      var local2:String = param1;
      this.initialize();
      local3 = local2.indexOf("#");
      if(local3 != -1) {
        if(local2.length > local3 + 1) {
          this._fragment = local2.substr(local3 + 1,local2.length - (local3 + 1));
        }
        local2 = local2.substr(0,local3);
      }
      local3 = local2.indexOf("?");
      if(local3 != -1) {
        if(local2.length > local3 + 1) {
          this._query = local2.substr(local3 + 1,local2.length - (local3 + 1));
        }
        local2 = local2.substr(0,local3);
      }
      local3 = local2.search(":");
      local4 = local2.search("/");
      var local5:Boolean = local3 != -1;
      var local6:Boolean = local4 != -1;
      var local7:Boolean = !local6 || local3 < local4;
      if(local5 && local7) {
        this._scheme = local2.substr(0,local3);
        this._scheme = this._scheme.toLowerCase();
        local2 = local2.substr(local3 + 1);
        if(local2.substr(0,2) != "//") {
          this._nonHierarchical = local2;
          if((this._valid = this.validateURI()) == false) {
            this.initialize();
          }
          return this.isValid();
        }
        this._nonHierarchical = "";
        local2 = local2.substr(2,local2.length - 2);
      } else {
        this._scheme = "";
        this._relative = true;
        this._nonHierarchical = "";
      }
      if(this.isRelative()) {
        this._authority = "";
        this._port = "";
        this._path = local2;
      } else {
        if(local2.substr(0,2) == "//") {
          while(local2.charAt(0) == "/") {
            local2 = local2.substr(1,local2.length - 1);
          }
        }
        local3 = local2.search("/");
        if(local3 == -1) {
          this._authority = local2;
          this._path = "";
        } else {
          this._authority = local2.substr(0,local3);
          this._path = local2.substr(local3,local2.length - local3);
        }
        local3 = this._authority.search("@");
        if(local3 != -1) {
          this._username = this._authority.substr(0,local3);
          this._authority = this._authority.substr(local3 + 1);
          local3 = this._username.search(":");
          if(local3 != -1) {
            this._password = this._username.substring(local3 + 1,this._username.length);
            this._username = this._username.substr(0,local3);
          } else {
            this._password = "";
          }
        } else {
          this._username = "";
          this._password = "";
        }
        local3 = this._authority.search(":");
        if(local3 != -1) {
          this._port = this._authority.substring(local3 + 1,this._authority.length);
          this._authority = this._authority.substr(0,local3);
        } else {
          this._port = "";
        }
        this._authority = this._authority.toLowerCase();
      }
      if((this._valid = this.validateURI()) == false) {
        this.initialize();
      }
      return this.isValid();
    }

    public function copyURI(param1:URI) : void {
      this._scheme = param1._scheme;
      this._authority = param1._authority;
      this._username = param1._username;
      this._password = param1._password;
      this._port = param1._port;
      this._path = param1._path;
      this._query = param1._query;
      this._fragment = param1._fragment;
      this._nonHierarchical = param1._nonHierarchical;
      this._valid = param1._valid;
      this._relative = param1._relative;
    }

    protected function verifyAlpha(param1:String) : Boolean {
      var local3:int = 0;
      var local2:RegExp = /[^a-z]/;
      param1 = param1.toLowerCase();
      local3 = param1.search(local2);
      if(local3 == -1) {
        return true;
      }
      return false;
    }

    public function isValid() : Boolean {
      return this._valid;
    }

    public function isAbsolute() : Boolean {
      return !this._relative;
    }

    public function isRelative() : Boolean {
      return this._relative;
    }

    public function isDirectory() : Boolean {
      if(this._path.length == 0) {
        return false;
      }
      return this._path.charAt(this.path.length - 1) == "/";
    }

    public function isHierarchical() : Boolean {
      return this.hierState;
    }

    public function get scheme() : String {
      return URI.unescapeChars(this._scheme);
    }

    public function set scheme(param1:String) : void {
      var local2:String = param1.toLowerCase();
      this._scheme = URI.fastEscapeChars(local2,URI.URIschemeExcludedBitmap);
    }

    public function get authority() : String {
      return URI.unescapeChars(this._authority);
    }

    public function set authority(param1:String) : void {
      param1 = param1.toLowerCase();
      this._authority = URI.fastEscapeChars(param1,URI.URIauthorityExcludedBitmap);
      this.hierState = true;
    }

    public function get username() : String {
      return URI.unescapeChars(this._username);
    }

    public function set username(param1:String) : void {
      this._username = URI.fastEscapeChars(param1,URI.URIuserpassExcludedBitmap);
      this.hierState = true;
    }

    public function get password() : String {
      return URI.unescapeChars(this._password);
    }

    public function set password(param1:String) : void {
      this._password = URI.fastEscapeChars(param1,URI.URIuserpassExcludedBitmap);
      this.hierState = true;
    }

    public function get port() : String {
      return URI.unescapeChars(this._port);
    }

    public function set port(param1:String) : void {
      this._port = URI.escapeChars(param1);
      this.hierState = true;
    }

    public function get path() : String {
      return URI.unescapeChars(this._path);
    }

    public function set path(param1:String) : void {
      this._path = URI.fastEscapeChars(param1,URI.URIpathExcludedBitmap);
      if(this._scheme == UNKNOWN_SCHEME) {
        this._scheme = "";
      }
      this.hierState = true;
    }

    public function get query() : String {
      return URI.unescapeChars(this._query);
    }

    public function set query(param1:String) : void {
      this._query = URI.fastEscapeChars(param1,URI.URIqueryExcludedBitmap);
    }

    public function get queryRaw() : String {
      return this._query;
    }

    public function set queryRaw(param1:String) : void {
      this._query = param1;
    }

    public function get fragment() : String {
      return URI.unescapeChars(this._fragment);
    }

    public function set fragment(param1:String) : void {
      this._fragment = URI.fastEscapeChars(param1,URIfragmentExcludedBitmap);
    }

    public function get nonHierarchical() : String {
      return URI.unescapeChars(this._nonHierarchical);
    }

    public function set nonHierarchical(param1:String) : void {
      this._nonHierarchical = URI.fastEscapeChars(param1,URInonHierexcludedBitmap);
      this.hierState = false;
    }

    public function setParts(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void {
      this.scheme = param1;
      this.authority = param2;
      this.port = param3;
      this.path = param4;
      this.query = param5;
      this.fragment = param6;
      this.hierState = true;
    }

    public function isOfType(param1:String) : Boolean {
      param1 = param1.toLowerCase();
      return this._scheme == param1;
    }

    public function getQueryValue(param1:String) : String {
      var local2:Object = null;
      var local3:String = null;
      var local4:String = null;
      local2 = this.getQueryByMap();
      for(local3 in local2) {
        if(local3 == param1) {
          return local2[local3];
        }
      }
      return new String("");
    }

    public function setQueryValue(param1:String, param2:String) : void {
      var local3:Object = null;
      local3 = this.getQueryByMap();
      local3[param1] = param2;
      this.setQueryByMap(local3);
    }

    public function getQueryByMap() : Object {
      var local1:String = null;
      var local2:String = null;
      var local3:Array = null;
      var local4:Array = null;
      var local5:String = null;
      var local6:String = null;
      var local7:int = 0;
      var local8:Object = new Object();
      local1 = this._query;
      local3 = local1.split("&");
      for each(local2 in local3) {
        if(local2.length != 0) {
          local4 = local2.split("=");
          if(local4.length > 0) {
            local5 = local4[0];
            if(local4.length > 1) {
              local6 = local4[1];
            } else {
              local6 = "";
            }
            local5 = queryPartUnescape(local5);
            local6 = queryPartUnescape(local6);
            local8[local5] = local6;
          }
        }
      }
      return local8;
    }

    public function setQueryByMap(param1:Object) : void {
      var local2:String = null;
      var local3:String = null;
      var local4:String = null;
      var local6:String = null;
      var local7:String = null;
      var local5:String = "";
      for(local2 in param1) {
        local3 = local2;
        local4 = param1[local2];
        if(local4 == null) {
          local4 = "";
        }
        local3 = queryPartEscape(local3);
        local4 = queryPartEscape(local4);
        local6 = local3;
        if(local4.length > 0) {
          local6 += "=";
          local6 += local4;
        }
        if(local5.length != 0) {
          local5 += "&";
        }
        local5 += local6;
      }
      this._query = local5;
    }

    public function toString() : String {
      if(this == null) {
        return "";
      }
      return this.toStringInternal(false);
    }

    public function toDisplayString() : String {
      return this.toStringInternal(true);
    }

    protected function toStringInternal(param1:Boolean) : String {
      var local2:String = "";
      var local3:String = "";
      if(this.isHierarchical() == false) {
        local2 += param1 ? this.scheme : this._scheme;
        local2 += ":";
        local2 += param1 ? this.nonHierarchical : this._nonHierarchical;
      } else {
        if(this.isRelative() == false) {
          if(this._scheme.length != 0) {
            local3 = param1 ? this.scheme : this._scheme;
            local2 += local3 + ":";
          }
          if(this._authority.length != 0 || this.isOfType("file")) {
            local2 += "//";
            if(this._username.length != 0) {
              local3 = param1 ? this.username : this._username;
              local2 += local3;
              if(this._password.length != 0) {
                local3 = param1 ? this.password : this._password;
                local2 += ":" + local3;
              }
              local2 += "@";
            }
            local3 = param1 ? this.authority : this._authority;
            local2 += local3;
            if(this.port.length != 0) {
              local2 += ":" + this.port;
            }
          }
        }
        local3 = param1 ? this.path : this._path;
        local2 += local3;
      }
      if(this._query.length != 0) {
        local3 = param1 ? this.query : this._query;
        local2 += "?" + local3;
      }
      if(this.fragment.length != 0) {
        local3 = param1 ? this.fragment : this._fragment;
        local2 += "#" + local3;
      }
      return local2;
    }

    public function forceEscape() : void {
      this.scheme = this.scheme;
      this.setQueryByMap(this.getQueryByMap());
      this.fragment = this.fragment;
      if(this.isHierarchical()) {
        this.authority = this.authority;
        this.path = this.path;
        this.port = this.port;
        this.username = this.username;
        this.password = this.password;
      } else {
        this.nonHierarchical = this.nonHierarchical;
      }
    }

    public function isOfFileType(param1:String) : Boolean {
      var local2:String = null;
      var local3:int = 0;
      local3 = param1.lastIndexOf(".");
      if(local3 != -1) {
        param1 = param1.substr(local3 + 1);
      }
      local2 = this.getExtension(true);
      if(local2 == "") {
        return false;
      }
      if(compareStr(local2,param1,false) == 0) {
        return true;
      }
      return false;
    }

    public function getExtension(param1:Boolean = false) : String {
      var local3:String = null;
      var local4:int = 0;
      var local2:String = this.getFilename();
      if(local2 == "") {
        return String("");
      }
      local4 = local2.lastIndexOf(".");
      if(local4 == -1 || local4 == 0) {
        return String("");
      }
      local3 = local2.substr(local4);
      if(param1 && local3.charAt(0) == ".") {
        local3 = local3.substr(1);
      }
      return local3;
    }

    public function getFilename(param1:Boolean = false) : String {
      var local3:String = null;
      var local4:int = 0;
      if(this.isDirectory()) {
        return String("");
      }
      var local2:String = this.path;
      local4 = local2.lastIndexOf("/");
      if(local4 != -1) {
        local3 = local2.substr(local4 + 1);
      } else {
        local3 = local2;
      }
      if(param1) {
        local4 = local3.lastIndexOf(".");
        if(local4 != -1) {
          local3 = local3.substr(0,local4);
        }
      }
      return local3;
    }

    public function getDefaultPort() : String {
      if(this._scheme == "http") {
        return String("80");
      }
      if(this._scheme == "ftp") {
        return String("21");
      }
      if(this._scheme == "file") {
        return String("");
      }
      if(this._scheme == "sftp") {
        return String("22");
      }
      return String("");
    }

    public function getRelation(param1:URI, param2:Boolean = true) : int {
      var local9:Array = null;
      var local10:Array = null;
      var local11:String = null;
      var local12:String = null;
      var local13:int = 0;
      var local3:URI = URI.resolve(this);
      var local4:URI = URI.resolve(param1);
      if(local3.isRelative() || local4.isRelative()) {
        return URI.NOT_RELATED;
      }
      if(local3.isHierarchical() == false || local4.isHierarchical() == false) {
        if(local3.isHierarchical() == false && local4.isHierarchical() == true || local3.isHierarchical() == true && local4.isHierarchical() == false) {
          return URI.NOT_RELATED;
        }
        if(local3.scheme != local4.scheme) {
          return URI.NOT_RELATED;
        }
        if(local3.nonHierarchical != local4.nonHierarchical) {
          return URI.NOT_RELATED;
        }
        return URI.EQUAL;
      }
      if(local3.scheme != local4.scheme) {
        return URI.NOT_RELATED;
      }
      if(local3.authority != local4.authority) {
        return URI.NOT_RELATED;
      }
      var local5:String = local3.port;
      var local6:String = local4.port;
      if(local5 == "") {
        local5 = local3.getDefaultPort();
      }
      if(local6 == "") {
        local6 = local4.getDefaultPort();
      }
      if(local5 != local6) {
        return URI.NOT_RELATED;
      }
      if(compareStr(local3.path,local4.path,param2)) {
        return URI.EQUAL;
      }
      var local7:String = local3.path;
      var local8:String = local4.path;
      if((local7 == "/" || local8 == "/") && (local7 == "" || local8 == "")) {
        return URI.EQUAL;
      }
      local9 = local7.split("/");
      local10 = local8.split("/");
      if(local9.length > local10.length) {
        local12 = local10[local10.length - 1];
        if(local12.length > 0) {
          return URI.NOT_RELATED;
        }
        local10.pop();
        local13 = 0;
        while(local13 < local10.length) {
          local11 = local9[local13];
          local12 = local10[local13];
          if(compareStr(local11,local12,param2) == false) {
            return URI.NOT_RELATED;
          }
          local13++;
        }
        return URI.CHILD;
      }
      if(local9.length < local10.length) {
        local11 = local9[local9.length - 1];
        if(local11.length > 0) {
          return URI.NOT_RELATED;
        }
        local9.pop();
        local13 = 0;
        while(local13 < local9.length) {
          local11 = local9[local13];
          local12 = local10[local13];
          if(compareStr(local11,local12,param2) == false) {
            return URI.NOT_RELATED;
          }
          local13++;
        }
        return URI.PARENT;
      }
      return URI.NOT_RELATED;
    }

    public function getCommonParent(param1:URI, param2:Boolean = true) : URI {
      var local6:String = null;
      var local7:String = null;
      var local3:URI = URI.resolve(this);
      var local4:URI = URI.resolve(param1);
      if(!local3.isAbsolute() || !local4.isAbsolute() || local3.isHierarchical() == false || local4.isHierarchical() == false) {
        return null;
      }
      var local5:int = local3.getRelation(local4);
      if(local5 == URI.NOT_RELATED) {
        return null;
      }
      local3.chdir(".");
      local4.chdir(".");
      do {
        local5 = local3.getRelation(local4,param2);
        if(local5 == URI.EQUAL || local5 == URI.PARENT) {
          break;
        }
        local6 = local3.toString();
        local3.chdir("..");
        local7 = local3.toString();
      }
      while(local6 != local7);
      return local3;
    }

    public function chdir(param1:String, param2:Boolean = false) : Boolean {
      var local3:URI = null;
      var local5:String = null;
      var local6:String = null;
      var local7:Array = null;
      var local8:Array = null;
      var local14:String = null;
      var local15:int = 0;
      var local17:String = null;
      var local4:String = param1;
      if(param2) {
        local4 = URI.escapeChars(param1);
      }
      if(local4 == "") {
        return true;
      }
      if(local4.substr(0,2) == "//") {
        local17 = this.scheme + ":" + local4;
        return this.constructURI(local17);
      }
      if(local4.charAt(0) == "?") {
        local4 = "./" + local4;
      }
      local3 = new URI(local4);
      if(local3.isAbsolute() || local3.isHierarchical() == false) {
        this.copyURI(local3);
        return true;
      }
      var local9:Boolean = false;
      var local10:Boolean = false;
      var local11:Boolean = false;
      var local12:Boolean = false;
      var local13:Boolean = false;
      local5 = this.path;
      local6 = local3.path;
      if(local5.length > 0) {
        local7 = local5.split("/");
      } else {
        local7 = new Array();
      }
      if(local6.length > 0) {
        local8 = local6.split("/");
      } else {
        local8 = new Array();
      }
      if(local7.length > 0 && local7[0] == "") {
        local11 = true;
        local7.shift();
      }
      if(local7.length > 0 && local7[local7.length - 1] == "") {
        local9 = true;
        local7.pop();
      }
      if(local8.length > 0 && local8[0] == "") {
        local12 = true;
        local8.shift();
      }
      if(local8.length > 0 && local8[local8.length - 1] == "") {
        local10 = true;
        local8.pop();
      }
      if(local12) {
        this.path = local3.path;
        this.queryRaw = local3.queryRaw;
        this.fragment = local3.fragment;
        return true;
      }
      if(local8.length == 0 && local3.query == "") {
        this.fragment = local3.fragment;
        return true;
      }
      if(local9 == false && local7.length > 0) {
        local7.pop();
      }
      this.queryRaw = local3.queryRaw;
      this.fragment = local3.fragment;
      local7 = local7.concat(local8);
      local15 = 0;
      while(local15 < local7.length) {
        local14 = local7[local15];
        local13 = false;
        if(local14 == ".") {
          local7.splice(local15,1);
          local15 -= 1;
          local13 = true;
        } else if(local14 == "..") {
          if(local15 >= 1) {
            if(local7[local15 - 1] != "..") {
              local7.splice(local15 - 1,2);
              local15 -= 2;
            }
          } else if(!this.isRelative()) {
            local7.splice(local15,1);
            local15 -= 1;
          }
          local13 = true;
        }
        local15++;
      }
      var local16:String = "";
      local10 ||= local13;
      local16 = this.joinPath(local7,local11,local10);
      this.path = local16;
      return true;
    }

    protected function joinPath(param1:Array, param2:Boolean, param3:Boolean) : String {
      var local5:int = 0;
      var local4:String = "";
      local5 = 0;
      while(local5 < param1.length) {
        if(local4.length > 0) {
          local4 += "/";
        }
        local4 += param1[local5];
        local5++;
      }
      if(param3 && local4.length > 0) {
        local4 += "/";
      }
      if(param2) {
        local4 = "/" + local4;
      }
      return local4;
    }

    public function makeAbsoluteURI(param1:URI) : Boolean {
      if(this.isAbsolute() || param1.isRelative()) {
        return false;
      }
      var local2:URI = new URI();
      local2.copyURI(param1);
      if(local2.chdir(this.toString()) == false) {
        return false;
      }
      this.copyURI(local2);
      return true;
    }

    public function makeRelativeURI(param1:URI, param2:Boolean = true) : Boolean {
      var local4:Array = null;
      var local5:Array = null;
      var local7:String = null;
      var local8:String = null;
      var local9:String = null;
      var local13:int = 0;
      var local3:URI = new URI();
      local3.copyURI(param1);
      var local6:Array = new Array();
      var local10:String = this.path;
      var local11:String = this.queryRaw;
      var local12:String = this.fragment;
      var local14:Boolean = false;
      var local15:Boolean = false;
      if(this.isRelative()) {
        return true;
      }
      if(local3.isRelative()) {
        return false;
      }
      if(this.isOfType(param1.scheme) == false || this.authority != param1.authority) {
        return false;
      }
      local15 = this.isDirectory();
      local3.chdir(".");
      local4 = local10.split("/");
      local5 = local3.path.split("/");
      if(local4.length > 0 && local4[0] == "") {
        local4.shift();
      }
      if(local4.length > 0 && local4[local4.length - 1] == "") {
        local15 = true;
        local4.pop();
      }
      if(local5.length > 0 && local5[0] == "") {
        local5.shift();
      }
      if(local5.length > 0 && local5[local5.length - 1] == "") {
        local5.pop();
      }
      while(local5.length > 0) {
        if(local4.length == 0) {
          break;
        }
        local7 = local4[0];
        local8 = local5[0];
        if(!compareStr(local7,local8,param2)) {
          break;
        }
        local4.shift();
        local5.shift();
      }
      var local16:String = "..";
      local13 = 0;
      while(local13 < local5.length) {
        local6.push(local16);
        local13++;
      }
      local6 = local6.concat(local4);
      local9 = this.joinPath(local6,false,local15);
      if(local9.length == 0) {
        local9 = "./";
      }
      this.setParts("","","",local9,local11,local12);
      return true;
    }

    public function unknownToURI(param1:String, param2:String = "http") : Boolean {
      var local3:String = null;
      var local5:String = null;
      if(param1.length == 0) {
        this.initialize();
        return false;
      }
      param1 = param1.replace(/\\/g,"/");
      if(param1.length >= 2) {
        local3 = param1.substr(0,2);
        if(local3 == "//") {
          param1 = param2 + ":" + param1;
        }
      }
      if(param1.length >= 3) {
        local3 = param1.substr(0,3);
        if(local3 == "://") {
          param1 = param2 + param1;
        }
      }
      var local4:URI = new URI(param1);
      if(local4.isHierarchical() == false) {
        if(local4.scheme == UNKNOWN_SCHEME) {
          this.initialize();
          return false;
        }
        this.copyURI(local4);
        this.forceEscape();
        return true;
      }
      if(local4.scheme != UNKNOWN_SCHEME && local4.scheme.length > 0) {
        if(local4.authority.length > 0 || local4.scheme == "file") {
          this.copyURI(local4);
          this.forceEscape();
          return true;
        }
        if(local4.authority.length == 0 && local4.path.length == 0) {
          this.setParts(local4.scheme,"","","","","");
          return false;
        }
      } else {
        local5 = local4.path;
        if(local5 == ".." || local5 == "." || local5.length >= 3 && local5.substr(0,3) == "../" || local5.length >= 2 && local5.substr(0,2) == "./") {
          this.copyURI(local4);
          this.forceEscape();
          return true;
        }
      }
      local4 = new URI(param2 + "://" + param1);
      if(local4.scheme.length > 0 && local4.authority.length > 0) {
        this.copyURI(local4);
        this.forceEscape();
        return true;
      }
      this.initialize();
      return false;
    }
  }
}
