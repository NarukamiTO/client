package alternativa.tanks.models.weapon.gauss.sfx {
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;
  import flash.display.BlendMode;

  public class GaussFlame extends Mesh {
    public function GaussFlame(param1:Number, param2:Material) {
      super();
      var local3:Vertex = addVertex(-param1 / 2,param1,0,0,0);
      var local4:Vertex = addVertex(-param1 / 2,0,0,0,1);
      var local5:Vertex = addVertex(param1 / 2,0,0,1,1);
      var local6:Vertex = addVertex(param1 / 2,param1,0,1,0);
      addQuadFace(local3,local4,local5,local6,param2);
      calculateFacesNormals();
      calculateBounds();
      blendMode = BlendMode.SCREEN;
      shadowMapAlphaThreshold = 2;
      depthMapAlphaThreshold = 2;
      useShadowMap = false;
      useLight = false;
    }
  }
}
