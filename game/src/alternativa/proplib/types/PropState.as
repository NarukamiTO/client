package alternativa.proplib.types {
  import alternativa.proplib.objects.PropObject;

  public class PropState {
    public static const DEFAULT_NAME:String = "default";

    private var _lods:Vector.<PropLOD> = new Vector.<PropLOD>();

    public function PropState() {
      super();
    }

    public function addLOD(prop:PropObject, distance:Number) : void {
      this._lods.push(new PropLOD(prop,distance));
    }

    public function get numLODs() : int {
      return this._lods.length;
    }

    public function lodByIndex(index:int) : PropLOD {
      return this._lods[index];
    }

    public function getDefaultObject() : PropObject {
      if(this._lods.length == 0) {
        throw new Error("No LODs found");
      }
      return PropLOD(this._lods[0]).prop;
    }

    public function traceState() : void {
      var lod:PropLOD = null;
      for each(lod in this._lods) {
        lod.traceLOD();
      }
    }
  }
}
