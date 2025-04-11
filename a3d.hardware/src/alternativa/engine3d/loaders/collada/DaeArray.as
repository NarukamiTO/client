package alternativa.engine3d.loaders.collada {
  use namespace collada;

  public class DaeArray extends DaeElement {
    public var array:Array;

    public function DaeArray(param1:XML, param2:DaeDocument) {
      super(param1,param2);
    }

    public function get type() : String {
      return String(data.localName());
    }

    override protected function parseImplementation() : Boolean {
      var local2:int = 0;
      this.array = parseStringArray(data);
      var local1:XML = data.@count[0];
      if(local1 != null) {
        local2 = parseInt(local1.toString(),10);
        if(this.array.length < local2) {
          document.logger.logNotEnoughDataError(data.@count[0]);
          return false;
        }
        this.array.length = local2;
        return true;
      }
      return false;
    }
  }
}
