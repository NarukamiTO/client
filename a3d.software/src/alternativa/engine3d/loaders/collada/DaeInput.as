package alternativa.engine3d.loaders.collada {
  use namespace collada;

  public class DaeInput extends DaeElement {
    public function DaeInput(param1:XML, param2:DaeDocument) {
      super(param1,param2);
    }

    public function get semantic() : String {
      var local1:XML = data.@semantic[0];
      return local1 == null ? null : local1.toString();
    }

    public function get source() : XML {
      return data.@source[0];
    }

    public function get offset() : int {
      var local1:XML = data.@offset[0];
      return local1 == null ? 0 : int(parseInt(local1.toString(),10));
    }

    public function get setNum() : int {
      var local1:XML = data.@set[0];
      return local1 == null ? 0 : int(parseInt(local1.toString(),10));
    }

    public function prepareSource(param1:int) : DaeSource {
      var local2:DaeSource = document.findSource(this.source);
      if(local2 != null) {
        local2.parse();
        if(local2.numbers != null && local2.stride >= param1) {
          return local2;
        }
      } else {
        document.logger.logNotFoundError(data.@source[0]);
      }
      return null;
    }
  }
}
