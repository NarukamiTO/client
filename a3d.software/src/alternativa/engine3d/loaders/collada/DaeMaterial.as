package alternativa.engine3d.loaders.collada {
  import alternativa.engine3d.materials.Material;

  use namespace collada;

  public class DaeMaterial extends DaeElement {
    public var material:Material;
    public var diffuseTexCoords:String;
    public var used:Boolean = false;

    public function DaeMaterial(param1:XML, param2:DaeDocument) {
      super(param1,param2);
    }

    private function parseSetParams() : Object {
      var local3:XML = null;
      var local4:DaeParam = null;
      var local1:Object = new Object();
      var local2:XMLList = data.instance_effect.setparam;
      for each(local3 in local2) {
        local4 = new DaeParam(local3,document);
        local1[local4.ref] = local4;
      }
      return local1;
    }

    private function get effectURL() : XML {
      return data.instance_effect.@url[0];
    }

    override protected function parseImplementation() : Boolean {
      var local1:DaeEffect = document.findEffect(this.effectURL);
      if(local1 != null) {
        local1.parse();
        this.material = local1.getMaterial(this.parseSetParams());
        this.diffuseTexCoords = local1.diffuseTexCoords;
        if(this.material != null) {
          this.material.name = name;
        }
        return true;
      }
      return false;
    }
  }
}
