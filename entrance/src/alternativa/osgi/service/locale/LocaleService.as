package alternativa.osgi.service.locale {
  import flash.display.BitmapData;
  import flash.display.DisplayObjectContainer;
  import flash.utils.Dictionary;

  public class LocaleService implements ILocaleService {
    private var strings:Object = {};
    private var images:Object = {};
    private var movies:Object = {};
    private var booleans:Object = {};
    private var numbers:Object = {};
    private var ints:Object = {};
    private var _language:String;
    private var _defaultLanguage:String;

    public function LocaleService(param1:String, param2:String) {
      super();
      this._language = param1;
      this._defaultLanguage = param2;
      this.strings = new Dictionary();
      this.images = new Dictionary();
    }

    public function setText(param1:String, param2:String) : void {
      this.strings[param1] = param2;
    }

    public function setImage(param1:String, param2:BitmapData) : void {
      this.images[param1] = param2;
    }

    public function setBoolean(param1:String, param2:Boolean) : void {
      this.booleans[param1] = param2;
    }

    public function setNumber(param1:String, param2:Number) : void {
      this.numbers[param1] = param2;
    }

    public function setInt(param1:String, param2:int) : void {
      this.ints[param1] = param2;
    }

    public function getText(param1:String, ... rest) : String {
      var local3:String = this.strings[param1];
      if(local3 == null) {
        return param1;
      }
      var local4:int = 0;
      while(local4 < rest.length) {
        local3 = local3.replace("%" + (local4 + 1),rest[local4]);
        local4++;
      }
      return local3;
    }

    public function getImage(param1:String) : BitmapData {
      return this.images[param1];
    }

    public function getBoolean(param1:String) : Boolean {
      return this.booleans[param1];
    }

    public function getNumber(param1:String) : Number {
      return this.numbers[param1];
    }

    public function getInt(param1:String) : int {
      return this.ints[param1];
    }

    public function get language() : String {
      return this._language;
    }

    public function get defaultLanguage() : String {
      return this._defaultLanguage;
    }

    public function getMovie(param1:String) : DisplayObjectContainer {
      return this.movies[param1];
    }

    public function setMovie(param1:String, param2:DisplayObjectContainer) : void {
      this.movies[param1] = param2;
    }

    public function getTextWithPrefix(param1:String) : Array {
      var local3:String = null;
      var local2:Array = [];
      for(local3 in this.strings) {
        if(local3.indexOf(param1) == 0) {
          local2.push(this.strings[local3]);
        }
      }
      return local2;
    }
  }
}
