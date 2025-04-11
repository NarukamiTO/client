package alternativa.proplib.types {
  import alternativa.proplib.objects.PropObject;

  public class PropLOD {
    public var prop:PropObject;
    public var distance:Number;

    public function PropLOD(prop:PropObject, distance:Number) {
      super();
      this.prop = prop;
      this.distance = distance;
    }

    public function traceLOD() : void {
      trace("Lod distance",this.distance);
      this.prop.traceProp();
    }
  }
}
