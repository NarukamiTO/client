package alternativa.tanks.models.battle.battlefield.map {
  import alternativa.engine3d.objects.BSP;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.proplib.objects.PropMesh;
  import alternativa.proplib.objects.PropObject;
  import alternativa.proplib.objects.PropSprite;
  import alternativa.utils.clearDictionary;
  import flash.utils.Dictionary;

  public class TexturedPropsRegistry {
    private var bspCollections:Dictionary = new Dictionary();
    private var meshCollections:Dictionary = new Dictionary();
    private var spriteCollections:Dictionary = new Dictionary();

    public function TexturedPropsRegistry() {
      super();
    }

    public function addBSP(param1:PropMesh, param2:String, param3:BSP) : void {
      var local4:TexturedBSPsCollection = this.getBSPsCollection(param1,param2);
      local4.addBsp(param3);
    }

    private function getBSPsCollection(param1:PropMesh, param2:String) : TexturedBSPsCollection {
      return TexturedBSPsCollection(this.getCollection(this.bspCollections,param1,param2,TexturedBSPsCollection));
    }

    public function addMesh(param1:PropMesh, param2:String, param3:Mesh, param4:String = null) : void {
      var local5:TexturedMeshesCollection = this.getMeshesCollection(param1,param2);
      local5.add(param3,param4);
    }

    private function getMeshesCollection(param1:PropMesh, param2:String) : TexturedMeshesCollection {
      return TexturedMeshesCollection(this.getCollection(this.meshCollections,param1,param2,TexturedMeshesCollection));
    }

    public function addSprite3D(param1:PropSprite, param2:Sprite3D) : void {
      var local3:TexturedSpritesCollection = this.getSpritesCollection(param1);
      local3.addSprite3D(param2);
    }

    private function getSpritesCollection(param1:PropSprite) : TexturedSpritesCollection {
      return TexturedSpritesCollection(this.getCollection(this.spriteCollections,param1,null,TexturedSpritesCollection));
    }

    private function getCollection(param1:Dictionary, param2:PropObject, param3:String, param4:Class) : TexturedPropsCollection {
      var local5:Dictionary = param1[param2];
      if(local5 == null) {
        local5 = new Dictionary();
        param1[param2] = local5;
      }
      var local6:TexturedPropsCollection = local5[param3];
      if(local6 == null) {
        local6 = new param4(param2,param3);
        local5[param3] = local6;
      }
      return local6;
    }

    public function getCollections() : Vector.<TexturedPropsCollection> {
      var local1:Vector.<TexturedPropsCollection> = new Vector.<TexturedPropsCollection>();
      this.collect(this.bspCollections,local1);
      this.collect(this.meshCollections,local1);
      this.collect(this.spriteCollections,local1);
      return local1;
    }

    private function collect(param1:Dictionary, param2:Vector.<TexturedPropsCollection>) : void {
      var local3:Dictionary = null;
      var local4:TexturedPropsCollection = null;
      for each(local3 in param1) {
        for each(local4 in local3) {
          param2.push(local4);
        }
      }
    }

    public function clear() : void {
      this.clearCollections(this.meshCollections);
      this.clearCollections(this.bspCollections);
      this.clearCollections(this.spriteCollections);
    }

    private function clearCollections(param1:Dictionary) : void {
      var local2:* = undefined;
      for(local2 in param1) {
        clearDictionary(param1[local2]);
        delete param1[local2];
      }
    }
  }
}
