package alternativa.tanks.models.battle.battlefield.map {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.objects.BSP;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Occluder;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.physics.collision.types.AABB;
  import alternativa.proplib.PropLibRegistry;
  import alternativa.proplib.PropLibrary;
  import alternativa.proplib.objects.PropMesh;
  import alternativa.proplib.objects.PropObject;
  import alternativa.proplib.objects.PropSprite;
  import alternativa.proplib.types.PropData;
  import alternativa.proplib.types.PropGroup;
  import alternativa.tanks.battle.scene3d.Object3DNames;
  import alternativa.utils.clearDictionary;
  import flash.geom.Matrix3D;
  import flash.geom.Vector3D;
  import flash.utils.Dictionary;

  public class MapGeometryParser {
    private static const objectMatrix:Matrix3D = new Matrix3D();
    private static const components:Vector.<Vector3D> = Vector.<Vector3D>([new Vector3D(),new Vector3D(),new Vector3D(1,1,1)]);

    private var propLibRegistry:PropLibRegistry;
    private var texturedPropsRegistry:TexturedPropsRegistry = new TexturedPropsRegistry();
    private var objects:Vector.<Object3D> = new Vector.<Object3D>();
    private var sprites:Vector.<Object3D> = new Vector.<Object3D>();
    private var occluders:Vector.<Occluder> = new Vector.<Occluder>();
    private var billboards:Vector.<Mesh> = new Vector.<Mesh>();
    private var meshProps:Vector.<Object3D> = new Vector.<Object3D>();
    private var propObjectByMesh:Dictionary = new Dictionary();
    private var textureNameByMesh:Dictionary = new Dictionary();
    private var mapBounds:AABB = new AABB();
    private var normalsCalculator:NormalsCalculator = new NormalsCalculator();
    private var christmasTree:Object3D;
    private var christmasTreeToys:Vector.<Object3D> = new Vector.<Object3D>();

    public function MapGeometryParser(param1:PropLibRegistry) {
      super();
      this.propLibRegistry = param1;
    }

    private static function getPropTextureName(param1:XML) : String {
      var local2:String = null;
      var local3:XMLList = param1.elements("texture-name");
      if(local3.length() > 0) {
        local2 = local3[0];
      }
      return local2 || PropMesh.DEFAULT_TEXTURE;
    }

    private static function readVector3D(param1:XMLList, param2:Vector3D) : void {
      var local3:XML = null;
      if(param1.length() > 0) {
        local3 = param1[0];
        param2.x = parseFloat(local3.x);
        param2.y = parseFloat(local3.y);
        param2.z = parseFloat(local3.z);
      } else {
        param2.x = param2.y = param2.z = 0;
      }
    }

    public function parse(param1:XML) : void {
      this.parseProps(param1);
      this.normalsCalculator.calculateNormals(this.meshProps);
      if(this.christmasTree != null) {
        (this.christmasTree as Mesh).calculateVerticesNormalsByAngle(Math.PI / 3,1);
      }
      this.makeBSPs();
    }

    private function parseProps(param1:XML) : void {
      var local2:XML = null;
      for each(local2 in param1.elements("static-geometry").prop) {
        this.parseProp(local2);
      }
    }

    private function parseProp(param1:XML) : void {
      var local2:PropObject = this.getPropObject(param1);
      if(local2 != null) {
        if(local2 is PropMesh) {
          this.parseMesh(param1,PropMesh(local2));
        } else if(local2 is PropSprite) {
          this.parseSprite(param1,PropSprite(local2));
        }
      }
    }

    private function getPropObject(param1:XML) : PropObject {
      var local2:String = param1.attribute("library-name");
      var local3:String = param1.attribute("group-name");
      var local4:String = param1.@name;
      var local5:PropLibrary = this.propLibRegistry.getLibrary(local2);
      if(local5 == null) {
        return null;
      }
      var local6:PropGroup = local5.rootGroup.getGroupByName(local3);
      if(local6 == null) {
        return null;
      }
      var local7:PropData = local6.getPropByName(local4);
      if(local7 == null) {
        return null;
      }
      return local7.getDefaultState().getDefaultObject();
    }

    private function parseMesh(param1:XML, param2:PropMesh) : void {
      if(param1.@name == "Billboard") {
        this.parseBillboard(param1,param2);
      } else {
        this.parseMeshProp(param1,param2);
      }
    }

    private function parseBillboard(param1:XML, param2:PropMesh) : void {
      var local3:Mesh = null;
      local3 = Mesh(param2.object.clone());
      local3.calculateFacesNormals();
      local3.calculateVerticesNormalsByAngle(0);
      local3.sorting = Sorting.DYNAMIC_BSP;
      local3.name = Object3DNames.STATIC;
      this.billboards.push(local3);
      var local4:String = getPropTextureName(param1);
      this.texturedPropsRegistry.addMesh(param2,local4,local3,"display");
      var local5:Vector3D = components[0];
      readVector3D(param1.position,local5);
      this.mapBounds.addPoint(local5.x,local5.y,local5.z);
      var local6:Vector3D = components[1];
      readVector3D(param1.rotation,local6);
      local3.x = local5.x;
      local3.y = local5.y;
      local3.z = local5.z;
      local3.rotationZ = local6.z;
      this.objects.push(local3);
    }

    private function parseMeshProp(param1:XML, param2:PropMesh) : void {
      var local3:Mesh = Mesh(param2.object.clone());
      var local4:Vector3D = components[0];
      readVector3D(param1.position,local4);
      local3.x = local4.x;
      local3.y = local4.y;
      local3.z = local4.z;
      this.mapBounds.addPoint(local4.x,local4.y,local4.z);
      var local5:Vector3D = components[1];
      readVector3D(param1.rotation,local5);
      local3.rotationZ = local5.z;
      var local6:String = getPropTextureName(param1);
      this.meshProps.push(local3);
      this.propObjectByMesh[local3] = param2;
      this.textureNameByMesh[local3] = local6;
      this.createOccluders(param2,components);
      if(param1.@name == "Elka") {
        this.christmasTree = local3;
      }
    }

    private function createOccluders(param1:PropMesh, param2:Vector.<Vector3D>) : void {
      var local3:Occluder = null;
      var local4:Matrix3D = null;
      var local5:Occluder = null;
      if(param1.occluders != null) {
        objectMatrix.recompose(param2);
        for each(local3 in param1.occluders) {
          local4 = local3.matrix;
          local4.append(objectMatrix);
          local5 = Occluder(local3.clone());
          local5.matrix = local4;
          this.occluders.push(local5);
        }
      }
    }

    private function parseSprite(param1:XML, param2:PropSprite) : void {
      var local5:Vector3D = null;
      var local3:Sprite3D = Sprite3D(param2.object.clone());
      if(param1.@name.indexOf("Shar") >= 0) {
        this.christmasTreeToys.push(local3);
        local5 = components[0];
        readVector3D(param1.position,local5);
        local3.x = local5.x;
        local3.y = local5.y;
        local3.z = local5.z;
        local3.name = param1.@name;
        return;
      }
      local3.shadowMapAlphaThreshold = 0;
      local3.softAttenuation = 80;
      this.sprites.push(local3);
      var local4:Vector3D = components[0];
      readVector3D(param1.position,local4);
      local3.x = local4.x;
      local3.y = local4.y;
      local3.z = local4.z;
      local3.width = param2.scale;
      this.texturedPropsRegistry.addSprite3D(param2,local3);
    }

    private function makeBSPs() : void {
      var local1:Object3D = null;
      var local2:Mesh = null;
      var local3:BSP = null;
      for each(local1 in this.meshProps) {
        local2 = local1 as Mesh;
        local3 = new BSP();
        local3.name = Object3DNames.STATIC;
        local3.createTree(local2,true);
        local3.x = local2.x;
        local3.y = local2.y;
        local3.z = local2.z;
        local3.rotationZ = local2.rotationZ;
        this.texturedPropsRegistry.addBSP(this.propObjectByMesh[local2],this.textureNameByMesh[local2],local3);
        this.objects.push(local3);
        if(local2 == this.christmasTree) {
          this.christmasTree = local3;
        }
      }
      this.meshProps.length = 0;
      clearDictionary(this.propObjectByMesh);
      clearDictionary(this.textureNameByMesh);
    }

    public function clear() : void {
      this.propLibRegistry = null;
      this.texturedPropsRegistry.clear();
      this.objects.length = 0;
      this.sprites.length = 0;
      this.occluders.length = 0;
      this.billboards.length = 0;
      this.christmasTree = null;
      this.christmasTreeToys.length = 0;
    }

    public function getObjects() : Vector.<Object3D> {
      return this.objects;
    }

    public function getSprites() : Vector.<Object3D> {
      return this.sprites;
    }

    public function getOccluders() : Vector.<Occluder> {
      return this.occluders;
    }

    public function getBillboards() : Vector.<Mesh> {
      return this.billboards;
    }

    public function getTexturedPropsCollections() : Vector.<TexturedPropsCollection> {
      return this.texturedPropsRegistry.getCollections();
    }

    public function getMapBounds() : AABB {
      return this.mapBounds;
    }

    public function getChristmasTree() : Object3D {
      return this.christmasTree;
    }

    public function getChristmasTreeToys() : Vector.<Object3D> {
      return this.christmasTreeToys;
    }
  }
}
