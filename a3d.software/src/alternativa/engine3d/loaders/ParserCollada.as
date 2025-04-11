package alternativa.engine3d.loaders {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.animation.AnimationClip;
  import alternativa.engine3d.animation.keys.Track;
  import alternativa.engine3d.containers.LODContainer;
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.loaders.collada.DaeDocument;
  import alternativa.engine3d.loaders.collada.DaeMaterial;
  import alternativa.engine3d.loaders.collada.DaeNode;
  import alternativa.engine3d.loaders.collada.DaeObject;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.materials.TextureMaterial;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class ParserCollada {
    public static const STATIC_OBJECT:uint = 0;
    public static const STATIC_GEOMETRY:uint = 1;
    public static const SPLITTER:uint = 2;

    public var objects:Vector.<Object3D>;
    public var parents:Vector.<Object3D>;
    public var hierarchy:Vector.<Object3D>;
    public var lights:Vector.<Light3D>;
    public var materials:Vector.<Material>;
    public var textureMaterials:Vector.<TextureMaterial>;
    public var animations:Vector.<AnimationClip>;

    private var layers:Dictionary;
    private var bspContainerChildrenTypes:Dictionary;

    public function ParserCollada() {
      super();
    }

    public static function parseAnimation(param1:XML) : AnimationClip {
      var local2:DaeDocument = new DaeDocument(param1);
      var local3:AnimationClip = new AnimationClip();
      collectAnimation(local3,local2.scene.nodes);
      return local3.numTracks > 0 ? local3 : null;
    }

    private static function collectAnimation(param1:AnimationClip, param2:Vector.<DaeNode>) : void {
      var local5:DaeNode = null;
      var local6:AnimationClip = null;
      var local7:int = 0;
      var local8:int = 0;
      var local9:Track = null;
      var local3:int = 0;
      var local4:int = int(param2.length);
      while(local3 < local4) {
        local5 = param2[local3];
        local6 = local5.parseAnimation();
        if(local6 != null) {
          local7 = 0;
          local8 = local6.numTracks;
          while(local7 < local8) {
            local9 = local6.getTrackAt(local7);
            param1.addTrack(local9);
            local7++;
          }
        } else {
          param1.addTrack(local5.createStaticTransformTrack());
        }
        collectAnimation(param1,local5.nodes);
        local3++;
      }
    }

    public function clean() : void {
      this.objects = null;
      this.parents = null;
      this.hierarchy = null;
      this.lights = null;
      this.animations = null;
      this.materials = null;
      this.textureMaterials = null;
      this.layers = null;
      this.bspContainerChildrenTypes = null;
    }

    public function getObjectLayer(param1:Object3D) : String {
      return this.layers[param1];
    }

    public function getBspContainerChildType(param1:Object3D) : uint {
      return this.bspContainerChildrenTypes[param1];
    }

    private function init(param1:XML) : DaeDocument {
      this.clean();
      this.objects = new Vector.<Object3D>();
      this.parents = new Vector.<Object3D>();
      this.hierarchy = new Vector.<Object3D>();
      this.lights = new Vector.<Light3D>();
      this.animations = new Vector.<AnimationClip>();
      this.materials = new Vector.<Material>();
      this.textureMaterials = new Vector.<TextureMaterial>();
      this.layers = new Dictionary();
      this.bspContainerChildrenTypes = new Dictionary();
      return new DaeDocument(param1);
    }

    public function parse(param1:XML, param2:String = null, param3:Boolean = false) : void {
      var local4:DaeDocument = this.init(param1);
      if(local4.scene != null) {
        this.parseNodes(local4.scene.nodes,null,false);
        this.parseMaterials(local4.materials,param2,param3);
      }
    }

    private function hasSignifiantChildren(param1:DaeNode, param2:Boolean) : Boolean {
      var local6:DaeNode = null;
      var local3:Vector.<DaeNode> = param1.nodes;
      var local4:int = 0;
      var local5:int = int(local3.length);
      while(local4 < local5) {
        local6 = local3[local4];
        local6.parse();
        if(local6.skins != null) {
          return true;
        }
        if(local6.skinOrTopmostJoint == false) {
          if(param2 == false) {
            return true;
          }
        }
        if(this.hasSignifiantChildren(local6,true)) {
          return true;
        }
        local4++;
      }
      return false;
    }

    private function addObject(param1:DaeObject, param2:Object3D, param3:String) : Object3D {
      var local6:LODContainer = null;
      var local7:Number = NaN;
      var local4:Object3D = param1.object as Object3D;
      this.objects.push(local4);
      this.parents.push(param2);
      if(param2 == null) {
        this.hierarchy.push(local4);
      }
      var local5:Object3DContainer = param2 as Object3DContainer;
      if(local5 != null) {
        local5.addChild(local4);
        local6 = local5 as LODContainer;
        if(local6 != null) {
          local7 = param1.lodDistance;
          if(local7 != 0) {
            local6.setChildDistance(local4,local7);
          }
        }
      }
      if(local4 is Light3D) {
        this.lights.push(Light3D(local4));
      }
      if(param1.animation != null) {
        this.animations.push(param1.animation);
      }
      if(Boolean(param3)) {
        this.layers[local4] = param3;
      }
      if(param1.isStaticGeometry) {
        this.bspContainerChildrenTypes[local4] = STATIC_GEOMETRY;
      } else if(param1.isSplitter) {
        this.bspContainerChildrenTypes[local4] = SPLITTER;
      }
      return local4;
    }

    private function addObjects(param1:Vector.<DaeObject>, param2:Object3D, param3:String) : Object3D {
      var local4:Object3D = this.addObject(param1[0],param2,param3);
      var local5:int = 1;
      var local6:int = int(param1.length);
      while(local5 < local6) {
        this.addObject(param1[local5],param2,param3);
        local5++;
      }
      return local4;
    }

    private function parseNodes(param1:Vector.<DaeNode>, param2:Object3DContainer, param3:Boolean = false) : void {
      var local6:DaeNode = null;
      var local7:Object3DContainer = null;
      var local8:Boolean = false;
      var local9:Object3D = null;
      var local4:int = 0;
      var local5:int = int(param1.length);
      while(local4 < local5) {
        local6 = param1[local4];
        local6.parse();
        local7 = null;
        local8 = false;
        if(local6.skins != null) {
          this.addObjects(local6.skins,param2,local6.layer);
        } else if(param3 == false && local6.skinOrTopmostJoint == false) {
          if(local6.objects != null) {
            local7 = this.addObjects(local6.objects,param2,local6.layer) as Object3DContainer;
          } else {
            local8 = true;
          }
        }
        if(local7 == null) {
          if(this.hasSignifiantChildren(local6,param3 || local6.skinOrTopmostJoint)) {
            local7 = new Object3DContainer();
            local7.name = local6.name;
            this.addObject(local6.applyAnimation(local6.applyTransformations(local7)),param2,local6.layer);
            this.parseNodes(local6.nodes,local7,param3 || local6.skinOrTopmostJoint);
            local7.calculateBounds();
          } else if(local8) {
            local9 = new Object3D();
            local9.name = local6.name;
            this.addObject(local6.applyAnimation(local6.applyTransformations(local9)),param2,local6.layer);
          }
        } else {
          this.parseNodes(local6.nodes,local7,param3 || local6.skinOrTopmostJoint);
          local7.calculateBounds();
        }
        local4++;
      }
    }

    private function trimPath(param1:String) : String {
      var local2:int = int(param1.lastIndexOf("/"));
      return local2 < 0 ? param1 : param1.substr(local2 + 1);
    }

    private function parseMaterials(param1:Object, param2:String, param3:Boolean) : void {
      var local4:TextureMaterial = null;
      var local5:DaeMaterial = null;
      var local6:String = null;
      var local7:int = 0;
      for each(local5 in param1) {
        if(local5.used) {
          local5.parse();
          this.materials.push(local5.material);
          local4 = local5.material as TextureMaterial;
          if(local4 != null) {
            this.textureMaterials.push(local4);
          }
        }
      }
      if(param3) {
        for each(local4 in this.textureMaterials) {
          if(local4.diffuseMapURL != null) {
            local4.diffuseMapURL = this.trimPath(this.fixURL(local4.diffuseMapURL));
          }
          if(local4.opacityMapURL != null) {
            local4.opacityMapURL = this.trimPath(this.fixURL(local4.opacityMapURL));
          }
        }
      } else {
        for each(local4 in this.textureMaterials) {
          if(local4.diffuseMapURL != null) {
            local4.diffuseMapURL = this.fixURL(local4.diffuseMapURL);
          }
          if(local4.opacityMapURL != null) {
            local4.opacityMapURL = this.fixURL(local4.opacityMapURL);
          }
        }
      }
      if(param2 != null) {
        param2 = this.fixURL(param2);
        local7 = int(param2.lastIndexOf("/"));
        local6 = local7 < 0 ? "" : param2.substr(0,local7);
        for each(local4 in this.textureMaterials) {
          if(local4.diffuseMapURL != null) {
            local4.diffuseMapURL = this.resolveURL(local4.diffuseMapURL,local6);
          }
          if(local4.opacityMapURL != null) {
            local4.opacityMapURL = this.resolveURL(local4.opacityMapURL,local6);
          }
        }
      }
    }

    private function fixURL(param1:String) : String {
      var local2:int = int(param1.indexOf("://"));
      local2 = local2 < 0 ? 0 : local2 + 3;
      var local3:int = int(param1.indexOf("?",local2));
      local3 = local3 < 0 ? int(param1.indexOf("#",local2)) : local3;
      var local4:String = param1.substring(local2,local3 < 0 ? 2147483647 : local3);
      local4 = local4.replace(/\\/g,"/");
      var local5:int = int(param1.indexOf("file://"));
      if(local5 >= 0) {
        if(param1.charAt(local2) == "/") {
          return "file://" + local4 + (local3 >= 0 ? param1.substring(local3) : "");
        }
        return "file:///" + local4 + (local3 >= 0 ? param1.substring(local3) : "");
      }
      return param1.substring(0,local2) + local4 + (local3 >= 0 ? param1.substring(local3) : "");
    }

    private function mergePath(param1:String, param2:String, param3:Boolean = false) : String {
      var local8:String = null;
      var local9:String = null;
      var local4:Array = param2.split("/");
      var local5:Array = param1.split("/");
      var local6:int = 0;
      var local7:int = int(local5.length);
      while(local6 < local7) {
        local8 = local5[local6];
        if(local8 == "..") {
          local9 = local4.pop();
          while(local9 == "." || local9 == "" && local9 != null) {
            local9 = local4.pop();
          }
          if(param3) {
            if(local9 == "..") {
              local4.push("..","..");
            } else if(local9 == null) {
              local4.push("..");
            }
          }
        } else {
          local4.push(local8);
        }
        local6++;
      }
      return local4.join("/");
    }

    private function resolveURL(param1:String, param2:String) : String {
      var local5:int = 0;
      var local6:String = null;
      var local7:String = null;
      var local8:String = null;
      var local9:int = 0;
      var local10:int = 0;
      var local11:int = 0;
      var local12:String = null;
      var local13:String = null;
      if(param2 == "") {
        return param1;
      }
      if(param1.charAt(0) == "." && param1.charAt(1) == "/") {
        return param2 + param1.substr(1);
      }
      if(param1.charAt(0) == "/") {
        return param1;
      }
      if(param1.charAt(0) == "." && param1.charAt(1) == ".") {
        local5 = int(param1.indexOf("?"));
        local5 = local5 < 0 ? int(param1.indexOf("#")) : local5;
        if(local5 < 0) {
          local7 = "";
          local6 = param1;
        } else {
          local7 = param1.substring(local5);
          local6 = param1.substring(0,local5);
        }
        local9 = int(param2.indexOf("/"));
        local10 = int(param2.indexOf(":"));
        local11 = int(param2.indexOf("//"));
        if(local11 < 0 || local11 > local9) {
          if(local10 >= 0 && local10 < local9) {
            local12 = param2.substring(0,local10 + 1);
            local8 = param2.substring(local10 + 1);
            if(local8.charAt(0) == "/") {
              return local12 + "/" + this.mergePath(local6,local8.substring(1),false) + local7;
            }
            return local12 + this.mergePath(local6,local8,false) + local7;
          }
          if(param2.charAt(0) == "/") {
            return "/" + this.mergePath(local6,param2.substring(1),false) + local7;
          }
          return this.mergePath(local6,param2,true) + local7;
        }
        local9 = int(param2.indexOf("/",local11 + 2));
        if(local9 >= 0) {
          local13 = param2.substring(0,local9 + 1);
          local8 = param2.substring(local9 + 1);
          return local13 + this.mergePath(local6,local8,false) + local7;
        }
        local13 = param2;
        return local13 + "/" + this.mergePath(local6,"",false);
      }
      var local3:int = int(param1.indexOf(":"));
      var local4:int = int(param1.indexOf("/"));
      if(local3 >= 0 && (local3 < local4 || local4 < 0)) {
        return param1;
      }
      return param2 + "/" + param1;
    }

    public function getObjectByName(param1:String) : Object3D {
      var local2:Object3D = null;
      for each(local2 in this.objects) {
        if(local2.name == param1) {
          return local2;
        }
      }
      return null;
    }

    public function getAnimationByObject(param1:Object) : AnimationClip {
      var local2:AnimationClip = null;
      var local3:Array = null;
      for each(local2 in this.animations) {
        local3 = local2.alternativa3d::_objects;
        if(local3.indexOf(param1) >= 0) {
          return local2;
        }
      }
      return null;
    }
  }
}
