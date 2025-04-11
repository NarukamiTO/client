package alternativa.proplib {
  public class PropLibRegistry {
    private var libs:Object = {};

    public function PropLibRegistry() {
      super();
    }

    public function addLibrary(lib:PropLibrary) : void {
      this.libs[lib.name] = lib;
    }

    public function getLibrary(libName:String) : PropLibrary {
      return this.libs[libName];
    }

    public function get libraries() : Vector.<PropLibrary> {
      var lib:PropLibrary = null;
      var res:Vector.<PropLibrary> = new Vector.<PropLibrary>();
      for each(lib in this.libs) {
        res.push(lib);
      }
      return res;
    }
  }
}
