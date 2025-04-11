package alternativa.tanks.utils {
  import alternativa.tanks.utils.thirdparty.URI;

  public class LinksInterceptor {
    private var _linkRegexp:RegExp = /(https?:\/\/|www\.)((([\w-\.]+)\.([a-z]{2,6}\.?))|(([а-я-\.]+)\.(рф\.?)))(\/[\w\.]*)*\/?([^\s\n]+)?/gi;
    private var _linkRegexpExtra:RegExp = new RegExp(this._linkRegexp);
    private var _linkRegexpAddon:RegExp = /[\[\]\{\}\|\*\(\)\@\$\^\'`~+№!]/gi;
    private var _allowedDomains:Vector.<String>;

    public var htmlFlag:Boolean = false;

    public function LinksInterceptor(param1:Vector.<String>) {
      super();
      this._allowedDomains = param1;
    }

    public function checkLinks(param1:String) : String {
      var local5:String = null;
      var local6:URI = null;
      this._linkRegexp.lastIndex = 0;
      var local2:String = "";
      var local3:Array = this._linkRegexp.exec(param1);
      var local4:int = 0;
      this.htmlFlag = false;
      while(local3 != null) {
        local2 += param1.substr(local4,local3.index - local4);
        local5 = param1.substr(local3.index,this._linkRegexp.lastIndex - local3.index);
        local6 = this.createUri(local5);
        if(!this.existsUrlInQuery(local6) && local5.indexOf("*") == -1) {
          local2 += " <u><a href=\'event:" + local6 + "\'>" + local5 + "</a></u> ";
          this.htmlFlag = true;
        } else {
          local2 += local5;
        }
        local4 = this._linkRegexp.lastIndex;
        local3 = this._linkRegexp.exec(param1);
      }
      return local2 + param1.substr(this._linkRegexp.lastIndex == 0 ? local4 : this._linkRegexp.lastIndex);
    }

    public function isInWhiteList(param1:String) : Boolean {
      var local2:URI = this.createUri(param1);
      var local3:String = local2.authority;
      return this._allowedDomains.indexOf(local3) != -1 && !this.existsUrlInQuery(local2);
    }

    private function createUri(param1:String) : URI {
      return new URI(param1.search(/^https?:\/\//i) == -1 ? "http://" + param1 : param1);
    }

    private function existsUrlInQuery(param1:URI) : Boolean {
      this._linkRegexpExtra.lastIndex = 0;
      if(this._linkRegexpExtra.exec(param1.queryRaw) != null) {
        return true;
      }
      this._linkRegexpAddon.lastIndex = 0;
      if(this._linkRegexpAddon.exec(param1.path) != null) {
        return true;
      }
      this._linkRegexpAddon.lastIndex = 0;
      if(this._linkRegexpAddon.exec(param1.fragment) != null) {
        return true;
      }
      return false;
    }
  }
}
