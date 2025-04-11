package alternativa.proplib.objects {
  import flash.geom.Vector3D;

  public class Triangle extends Polygon {
    public function Triangle(v0:Vector3D, v1:Vector3D, v2:Vector3D, twoSided:Boolean) {
      var points:Vector.<Number> = Vector.<Number>([v0.x,v0.y,v0.z,v1.x,v1.y,v1.z,v2.x,v2.y,v2.z]);
      var uv:Vector.<Number> = Vector.<Number>([0,0,0,1,1,1]);
      super(points,uv,twoSided);
    }
  }
}
