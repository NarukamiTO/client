package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;

  use namespace alternativa3d;

  public class Wrapper {
    alternativa3d static var collector:Wrapper;

    alternativa3d var next:Wrapper;
    alternativa3d var vertex:Vertex;

    public function Wrapper() {
      super();
    }

    alternativa3d static function create() : Wrapper {
      var local1:Wrapper = null;
      if(alternativa3d::collector != null) {
        local1 = alternativa3d::collector;
        alternativa3d::collector = alternativa3d::collector.alternativa3d::next;
        local1.alternativa3d::next = null;
        return local1;
      }
      return new Wrapper();
    }

    alternativa3d function create() : Wrapper {
      var local1:Wrapper = null;
      if(alternativa3d::collector != null) {
        local1 = alternativa3d::collector;
        alternativa3d::collector = alternativa3d::collector.alternativa3d::next;
        local1.alternativa3d::next = null;
        return local1;
      }
      return new Wrapper();
    }
  }
}
