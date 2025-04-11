package alternativa.engine3d.loaders.collada {
  use namespace collada;

  public class DaeImage extends DaeElement {
    public function DaeImage(param1:XML, param2:DaeDocument) {
      super(param1,param2);
    }

    public function get init_from() : String {
      var local2:XML = null;
      var local1:XML = data.init_from[0];
      if(local1 != null) {
        if(document.versionMajor > 4) {
          local2 = local1.ref[0];
          return local2 == null ? null : local2.text().toString();
        }
        return local1.text().toString();
      }
      return null;
    }
  }
}
