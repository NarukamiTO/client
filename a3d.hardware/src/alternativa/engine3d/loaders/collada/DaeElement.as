package alternativa.engine3d.loaders.collada {
  use namespace collada;

  public class DaeElement {
    public var document:DaeDocument;
    public var data:XML;

    private var _parsed:int = -1;

    public function DaeElement(param1:XML, param2:DaeDocument) {
      super();
      this.document = param2;
      this.data = param1;
    }

    public function parse() : Boolean {
      if(this._parsed < 0) {
        this._parsed = this.parseImplementation() ? 1 : 0;
        return this._parsed != 0;
      }
      return this._parsed != 0;
    }

    protected function parseImplementation() : Boolean {
      return true;
    }

    protected function parseStringArray(param1:XML) : Array {
      return param1.text().toString().split(/\s+/);
    }

    protected function parseNumbersArray(param1:XML) : Array {
      var local5:String = null;
      var local2:Array = param1.text().toString().split(/\s+/);
      var local3:int = 0;
      var local4:int = int(local2.length);
      while(local3 < local4) {
        local5 = local2[local3];
        if(local5.indexOf(",") != -1) {
          local5 = local5.replace(/,/,".");
        }
        local2[local3] = parseFloat(local5);
        local3++;
      }
      return local2;
    }

    protected function parseIntsArray(param1:XML) : Array {
      var local5:String = null;
      var local2:Array = param1.text().toString().split(/\s+/);
      var local3:int = 0;
      var local4:int = int(local2.length);
      while(local3 < local4) {
        local5 = local2[local3];
        local2[local3] = parseInt(local5,10);
        local3++;
      }
      return local2;
    }

    protected function parseNumber(param1:XML) : Number {
      var local2:String = param1.toString().replace(/,/,".");
      return parseFloat(local2);
    }

    public function get id() : String {
      var local1:XML = this.data.@id[0];
      return local1 == null ? null : local1.toString();
    }

    public function get sid() : String {
      var local1:XML = this.data.@sid[0];
      return local1 == null ? null : local1.toString();
    }

    public function get name() : String {
      var local1:XML = this.data.@name[0];
      return local1 == null ? null : local1.toString();
    }
  }
}
