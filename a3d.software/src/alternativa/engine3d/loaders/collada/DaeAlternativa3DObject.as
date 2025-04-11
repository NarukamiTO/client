package alternativa.engine3d.loaders.collada {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.containers.BSPContainer;
  import alternativa.engine3d.containers.ConflictContainer;
  import alternativa.engine3d.containers.DistanceSortContainer;
  import alternativa.engine3d.containers.KDContainer;
  import alternativa.engine3d.containers.LODContainer;
  import alternativa.engine3d.core.Clipping;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Sprite3D;

  use namespace collada;
  use namespace alternativa3d;
  use namespace daeAlternativa3DLibrary;
  use namespace daeAlternativa3DMesh;

  public class DaeAlternativa3DObject extends DaeElement {
    public var isSplitter:Boolean = false;
    public var isBaseGeometry:Boolean = false;

    public function DaeAlternativa3DObject(param1:XML, param2:DaeDocument) {
      super(param1,param2);
    }

    override protected function parseImplementation() : Boolean {
      var local1:String = null;
      var local2:XML = null;
      var local3:XML = null;
      if(data.localName() == "mesh") {
        local2 = data.baseGeometry[0];
        if(local2 != null) {
          local1 = local2.toString();
          this.isBaseGeometry = local1 == "true" || parseInt(local1) != 0;
        }
        local3 = data.splitter[0];
        if(local3 != null) {
          local1 = local3.toString();
          this.isSplitter = local1 == "true" || parseInt(local1) != 0;
        }
      }
      return true;
    }

    public function parseContainer(param1:String) : Object3DContainer {
      var local2:Object3DContainer = null;
      var local3:XML = null;
      switch(data.localName()) {
        case "object3d":
          local2 = new Object3DContainer();
          local2.name = param1;
          return this.setParams(local2);
        case "distanceSort":
          local2 = new DistanceSortContainer();
          local2.name = param1;
          return this.setParams(local2);
        case "conflict":
          local2 = new ConflictContainer();
          local2.name = param1;
          return this.setParams(local2);
        case "kdTree":
          local2 = new KDContainer();
          local2.name = param1;
          return this.setParams(local2);
        case "bspTree":
          local2 = new BSPContainer();
          local3 = data.clipping[0];
          if(local3 != null) {
            (local2 as BSPContainer).clipping = this.getClippingValue(local3);
          }
          local2.name = param1;
          return this.setParams(local2);
        default:
          return null;
      }
    }

    private function getClippingValue(param1:XML) : int {
      switch(param1.toString()) {
        case "BOUND_CULLING":
          return Clipping.BOUND_CULLING;
        case "FACE_CULLING":
          return Clipping.FACE_CULLING;
        case "FACE_CLIPPING":
          return Clipping.FACE_CLIPPING;
        default:
          return Clipping.BOUND_CULLING;
      }
    }

    private function getSortingValue(param1:XML) : int {
      switch(param1.toString()) {
        case "STATIC_BSP":
          return 3;
        case "DYNAMIC_BSP":
          return Sorting.DYNAMIC_BSP;
        case "NONE":
          return Sorting.NONE;
        case "AVERAGE_Z":
          return Sorting.AVERAGE_Z;
        default:
          return Sorting.NONE;
      }
    }

    public function parseSprite3D(param1:String, param2:Material = null) : Sprite3D {
      var local3:Sprite3D = null;
      var local4:XML = null;
      var local5:XML = null;
      var local6:XML = null;
      if(data.localName() == "sprite") {
        local3 = new Sprite3D(100,100,param2);
        local3.name = param1;
        local4 = data.sorting[0];
        local5 = data.clipping[0];
        if(local4 != null) {
          local3.sorting = this.getSortingValue(local4);
        }
        if(local5 != null) {
          local3.clipping = this.getClippingValue(local5);
        }
        local6 = data.rotation[0];
        if(local6 != null) {
          local3.rotation = parseInt(local6.toString()) * Math.PI / 180;
        }
        return this.setParams(local3);
      }
      return null;
    }

    public function applyA3DMeshProperties(param1:Mesh) : void {
      var local2:XML = null;
      var local3:XML = null;
      var local4:XML = null;
      var local5:Boolean = false;
      if(data.localName() == "mesh") {
        local2 = data.sorting[0];
        local3 = data.clipping[0];
        local4 = data.optimizeBSP[0];
        if(local3 != null) {
          param1.clipping = this.getClippingValue(local3);
        }
        local5 = local4 != null ? local4.toString() != "false" : true;
        if(local2 != null) {
          param1.sorting = this.getSortingValue(local2);
          if(local5) {
            param1.alternativa3d::transformId = 1;
          }
        }
        this.setParams(param1);
      }
    }

    public function parseLOD(param1:String, param2:DaeNode) : LODContainer {
      var local3:LODContainer = null;
      var local4:XMLList = null;
      var local5:int = 0;
      var local6:int = 0;
      var local7:XML = null;
      var local8:DaeNode = null;
      var local9:DaeObject = null;
      if(data.localName() == "lod") {
        local3 = new LODContainer();
        local3.name = param1;
        local4 = data.level;
        local5 = int(local4.length());
        local6 = 0;
        while(local6 < local5) {
          local7 = local4[local6];
          local8 = document.findNode(local7.@url[0]);
          if(local8.scene == null) {
            param2.nodes.push(local8);
          }
          local9 = null;
          if(local8 != null) {
            if(local8.rootJoint != null) {
              local8 = local8.rootJoint;
              local8.parse();
              if(local8.skins != null) {
                local9 = local8.skins[0];
              }
            } else {
              local8.parse();
              if(local8.objects != null) {
                local9 = local8.objects[0];
              }
            }
          } else {
            document.logger.logNotFoundError(local7.@url[0]);
          }
          if(local9 != null) {
            local9.lodDistance = parseNumber(local7.@distance[0]);
          }
          local6++;
        }
        return this.setParams(local3);
      }
      return null;
    }

    private function setParams(param1:*) : * {
      var param:XML = null;
      var name:String = null;
      var value:String = null;
      var num:Number = NaN;
      var object:* = param1;
      var params:XMLList = data.param;
      var i:int = 0;
      var count:int = int(params.length());
      while(i < count) {
        param = params[i];
        try {
          name = param.@name[0].toString();
          value = param.text().toString();
          if(value == "true") {
            object[name] = true;
          } else if(value == "false") {
            object[name] = false;
          } else if(value.charAt(0) == "\"" && value.charAt(value.length - 1) == "\"" || value.charAt(0) == "\'" && value.charAt(value.length - 1) == "\'") {
            object[name] = value;
          } else {
            if(value.indexOf(".") >= 0) {
              num = parseFloat(value);
            } else if(value.indexOf(",") >= 0) {
              value = value.replace(/,/,".");
              num = parseFloat(value);
            } else {
              num = parseInt(value);
            }
            if(isNaN(num)) {
              object[name] = value;
            } else {
              object[name] = num;
            }
          }
        }
        catch(e:Error) {
        }
        i++;
      }
      return object;
    }
  }
}
