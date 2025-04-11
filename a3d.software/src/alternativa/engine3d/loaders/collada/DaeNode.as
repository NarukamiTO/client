package alternativa.engine3d.loaders.collada {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.animation.AnimationClip;
  import alternativa.engine3d.animation.keys.NumberTrack;
  import alternativa.engine3d.animation.keys.Track;
  import alternativa.engine3d.animation.keys.TransformTrack;
  import alternativa.engine3d.containers.LODContainer;
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.objects.BSP;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Skin;
  import alternativa.engine3d.objects.Sprite3D;
  import flash.geom.Matrix3D;
  import flash.geom.Vector3D;

  use namespace collada;
  use namespace alternativa3d;
  use namespace daeAlternativa3DInstance;

  public class DaeNode extends DaeElement {
    public var scene:DaeVisualScene;
    public var parent:DaeNode;
    public var skinOrTopmostJoint:Boolean = false;
    public var rootJoint:DaeNode = null;

    private var channels:Vector.<DaeChannel>;
    private var instanceControllers:Vector.<DaeInstanceController>;

    public var nodes:Vector.<DaeNode>;
    public var objects:Vector.<DaeObject>;
    public var skins:Vector.<DaeObject>;

    public function DaeNode(param1:XML, param2:DaeDocument, param3:DaeVisualScene = null, param4:DaeNode = null) {
      super(param1,param2);
      this.scene = param3;
      this.parent = param4;
      this.constructNodes();
    }

    public function get animName() : String {
      var local1:String = this.name;
      return local1 == null ? this.id : local1;
    }

    private function constructNodes() : void {
      var local4:DaeNode = null;
      var local1:XMLList = data.node;
      var local2:int = int(local1.length());
      this.nodes = new Vector.<DaeNode>(local2);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = new DaeNode(local1[local3],document,this.scene,this);
        if(local4.id != null) {
          document.nodes[local4.id] = local4;
        }
        this.nodes[local3] = local4;
        local3++;
      }
    }

    internal function registerInstanceControllers() : void {
      var local2:int = 0;
      var local4:XML = null;
      var local5:DaeInstanceController = null;
      var local6:Vector.<DaeNode> = null;
      var local7:int = 0;
      var local8:DaeNode = null;
      var local9:int = 0;
      var local1:XMLList = data.instance_controller;
      var local3:int = int(local1.length());
      local2 = 0;
      while(local2 < local3) {
        this.skinOrTopmostJoint = true;
        local4 = local1[local2];
        local5 = new DaeInstanceController(local4,document,this);
        if(local5.parse()) {
          local6 = local5.topmostJoints;
          local7 = int(local6.length);
          if(local7 > 0) {
            local8 = local6[0];
            local8.addInstanceController(local5);
            if(this.rootJoint == null) {
              this.rootJoint = local8;
            }
            local9 = 0;
            while(local9 < local7) {
              local6[local9].skinOrTopmostJoint = true;
              local9++;
            }
          }
        }
        local2++;
      }
      local3 = int(this.nodes.length);
      local2 = 0;
      while(local2 < local3) {
        this.nodes[local2].registerInstanceControllers();
        local2++;
      }
    }

    public function addChannel(param1:DaeChannel) : void {
      if(this.channels == null) {
        this.channels = new Vector.<DaeChannel>();
      }
      this.channels.push(param1);
    }

    public function addInstanceController(param1:DaeInstanceController) : void {
      if(this.instanceControllers == null) {
        this.instanceControllers = new Vector.<DaeInstanceController>();
      }
      this.instanceControllers.push(param1);
    }

    override protected function parseImplementation() : Boolean {
      this.skins = this.parseSkins();
      this.objects = this.parseObjects();
      return true;
    }

    private function parseInstanceMaterials(param1:XML) : Object {
      var local6:DaeInstanceMaterial = null;
      var local2:Object = new Object();
      var local3:XMLList = param1.bind_material.technique_common.instance_material;
      var local4:int = 0;
      var local5:int = int(local3.length());
      while(local4 < local5) {
        local6 = new DaeInstanceMaterial(local3[local4],document);
        local2[local6.symbol] = local6;
        local4++;
      }
      return local2;
    }

    public function getNodeBySid(param1:String) : DaeNode {
      var local5:int = 0;
      var local6:Vector.<Vector.<DaeNode>> = null;
      var local7:Vector.<DaeNode> = null;
      var local8:int = 0;
      var local9:int = 0;
      var local10:DaeNode = null;
      if(param1 == this.sid) {
        return this;
      }
      var local2:Vector.<Vector.<DaeNode>> = new Vector.<Vector.<DaeNode>>();
      var local3:Vector.<Vector.<DaeNode>> = new Vector.<Vector.<DaeNode>>();
      local2.push(this.nodes);
      var local4:int = int(local2.length);
      while(local4 > 0) {
        local5 = 0;
        while(local5 < local4) {
          local7 = local2[local5];
          local8 = int(local7.length);
          local9 = 0;
          while(local9 < local8) {
            local10 = local7[local9];
            if(local10.sid == param1) {
              return local10;
            }
            if(local10.nodes.length > 0) {
              local3.push(local10.nodes);
            }
            local9++;
          }
          local5++;
        }
        local6 = local2;
        local2 = local3;
        local3 = local6;
        local3.length = 0;
        local4 = int(local2.length);
      }
      return null;
    }

    public function parseSkins() : Vector.<DaeObject> {
      var local4:DaeInstanceController = null;
      var local5:DaeObject = null;
      var local6:Skin = null;
      var local7:BSP = null;
      var local8:DaeObject = null;
      if(this.instanceControllers == null) {
        return null;
      }
      var local1:Vector.<DaeObject> = new Vector.<DaeObject>();
      var local2:int = 0;
      var local3:int = int(this.instanceControllers.length);
      while(local2 < local3) {
        local4 = this.instanceControllers[local2];
        local4.parse();
        local5 = local4.parseSkin(this.parseInstanceMaterials(local4.data));
        if(local5 != null) {
          local6 = Skin(local5.object);
          local6.name = local4.node.name;
          if(this.isAlternativa3DObject(local4.node)) {
            this.updateAlternativa3DMesh(local4.node,local6,local5);
            if(local6.sorting == 3) {
              local7 = new BSP();
              local7.name = local6.name;
              local7.splitAnalysis = local6.alternativa3d::transformId > 0;
              local7.createTree(local6,true);
              local8 = this.applyAnimation(this.applyTransformations(local7));
              local8.isSplitter = local5.isSplitter;
              local8.isStaticGeometry = local5.isStaticGeometry;
              local1.push(local8);
            } else {
              if(local6.sorting == Sorting.DYNAMIC_BSP && local6.alternativa3d::transformId > 0) {
                local6.optimizeForDynamicBSP();
              }
              local1.push(local5);
            }
          } else {
            local1.push(local5);
          }
        }
        local2++;
      }
      return local1.length > 0 ? local1 : null;
    }

    public function parseObjects() : Vector.<DaeObject> {
      var local3:int = 0;
      var local4:int = 0;
      var local5:DaeObject = null;
      var local6:XML = null;
      var local7:DaeLight = null;
      var local8:DaeGeometry = null;
      var local9:Light3D = null;
      var local10:Matrix3D = null;
      var local11:Mesh = null;
      var local12:DaeObject = null;
      var local13:BSP = null;
      var local1:Vector.<DaeObject> = new Vector.<DaeObject>();
      if(this.isAlternativa3DObject(this)) {
        local5 = this.parseAlternativa3DObject();
        if(local5 != null) {
          local1.push(local5);
        }
      }
      var local2:XMLList = data.children();
      local3 = 0;
      local4 = int(local2.length());
      while(local3 < local4) {
        local6 = local2[local3];
        switch(local6.localName()) {
          case "instance_light":
            local7 = document.findLight(local6.@url[0]);
            if(local7 != null) {
              local9 = local7.parseLight();
              if(local9 != null) {
                local9.name = name;
                if(local7.revertDirection) {
                  local10 = new Matrix3D();
                  local10.appendRotation(180,Vector3D.X_AXIS);
                  local1.push(new DaeObject(this.applyTransformations(local9,local10)));
                } else {
                  local1.push(this.applyAnimation(this.applyTransformations(local9)));
                }
              }
            } else {
              document.logger.logNotFoundError(local6.@url[0]);
            }
            break;
          case "instance_geometry":
            local8 = document.findGeometry(local6.@url[0]);
            if(local8 != null) {
              local8.parse();
              local11 = local8.parseMesh(this.parseInstanceMaterials(local6));
              if(local11 != null) {
                local11.name = name;
                local12 = this.applyAnimation(this.applyTransformations(local11));
                if(this.isAlternativa3DObject(this)) {
                  this.updateAlternativa3DMesh(this,local11,local12);
                  if(local11.sorting == 3) {
                    local13 = new BSP();
                    local13.splitAnalysis = local11.alternativa3d::transformId > 0;
                    local13.createTree(local11,true);
                    local13.name = local11.name;
                    local13.matrix = local11.matrix;
                    local12.object = local13;
                  } else if(local11.sorting == Sorting.DYNAMIC_BSP && local11.alternativa3d::transformId > 0) {
                    local11.optimizeForDynamicBSP();
                  }
                }
                local1.push(local12);
              }
            } else {
              document.logger.logNotFoundError(local6.@url[0]);
            }
            break;
          case "instance_node":
            document.logger.logInstanceNodeError(local6);
            break;
        }
        local3++;
      }
      return local1.length > 0 ? local1 : null;
    }

    private function getMatrix(param1:Matrix3D = null) : Matrix3D {
      var local3:Array = null;
      var local6:XML = null;
      var local7:XML = null;
      var local2:Matrix3D = param1 == null ? new Matrix3D() : param1;
      var local4:XMLList = data.children();
      var local5:int = local4.length() - 1;
      for(; local5 >= 0; local5--) {
        local6 = local4[local5];
        local7 = local6.@sid[0];
        if(local7 != null && local7.toString() == "post-rotationY") {
          continue;
        }
        switch(local6.localName()) {
          case "scale":
            local3 = parseNumbersArray(local6);
            local2.appendScale(local3[0],local3[1],local3[2]);
            break;
          case "rotate":
            local3 = parseNumbersArray(local6);
            local2.appendRotation(local3[3],new Vector3D(local3[0],local3[1],local3[2]));
            break;
          case "translate":
            local3 = parseNumbersArray(local6);
            local2.appendTranslation(local3[0],local3[1],local3[2]);
            break;
          case "matrix":
            local3 = parseNumbersArray(local6);
            local2.append(new Matrix3D(Vector.<Number>([local3[0],local3[4],local3[8],local3[12],local3[1],local3[5],local3[9],local3[13],local3[2],local3[6],local3[10],local3[14],local3[3],local3[7],local3[11],local3[15]])));
            break;
          case "lookat":
            break;
          case "skew":
            document.logger.logSkewError(local6);
            break;
        }
      }
      return local2;
    }

    public function applyTransformations(param1:Object3D, param2:Matrix3D = null, param3:Matrix3D = null) : Object3D {
      var local4:Matrix3D = null;
      if(param3 != null) {
        local4 = this.getMatrix(param2);
        local4.append(param3);
        param1.matrix = local4;
      } else {
        param1.matrix = this.getMatrix(param2);
      }
      return param1;
    }

    private function isAlternativa3DObject(param1:DaeNode) : Boolean {
      var node:DaeNode = param1;
      return node.data.extra.technique.(@profile == "Alternativa3D")[0] != null;
    }

    private function parseAlternativa3DObject() : DaeObject {
      var techniqueXML:XML = null;
      var profile:XML = null;
      var containerXML:XML = null;
      var spriteXML:XML = null;
      var lodXML:XML = null;
      var daeContainer:DaeAlternativa3DObject = null;
      var container:Object3DContainer = null;
      var daeSprite:DaeAlternativa3DObject = null;
      var sprite:Sprite3D = null;
      var material:DaeMaterial = null;
      var daeLod:DaeAlternativa3DObject = null;
      var lod:LODContainer = null;
      techniqueXML = data.extra.technique.(@profile == "Alternativa3D")[0];
      profile = techniqueXML.instance[0];
      if(profile != null) {
        containerXML = profile.instance_container[0];
        if(containerXML != null) {
          daeContainer = document.findAlternativa3DObject(containerXML.@url[0]);
          if(daeContainer != null) {
            container = daeContainer.parseContainer(name);
            return container != null ? this.applyAnimation(this.applyTransformations(container)) : null;
          }
          document.logger.logNotFoundError(containerXML.@url[0]);
        }
        spriteXML = profile.instance_sprite[0];
        if(spriteXML != null) {
          daeSprite = document.findAlternativa3DObject(spriteXML.@url[0]);
          if(daeSprite != null) {
            material = document.findMaterial(spriteXML.instance_material.@target[0]);
            if(material != null) {
              material.parse();
              material.used = true;
              sprite = daeSprite.parseSprite3D(name,material.material);
            } else {
              sprite = daeSprite.parseSprite3D(name);
            }
            return sprite != null ? this.applyAnimation(this.applyTransformations(sprite)) : null;
          }
          document.logger.logNotFoundError(spriteXML.@url[0]);
        }
        lodXML = profile.instance_lod[0];
        if(lodXML != null) {
          daeLod = document.findAlternativa3DObject(lodXML.@url[0]);
          if(daeLod != null) {
            lod = daeLod.parseLOD(name,this);
            return lod != null ? this.applyAnimation(this.applyTransformations(lod)) : null;
          }
          document.logger.logNotFoundError(lodXML.@url[0]);
        }
      }
      return null;
    }

    private function updateAlternativa3DMesh(param1:DaeNode, param2:Mesh, param3:DaeObject) : void {
      var techniqueXML:XML = null;
      var profile:XML = null;
      var meshXML:XML = null;
      var daeMesh:DaeAlternativa3DObject = null;
      var node:DaeNode = param1;
      var mesh:Mesh = param2;
      var daeObject:DaeObject = param3;
      techniqueXML = node.data.extra.technique.(@profile == "Alternativa3D")[0];
      profile = techniqueXML.instance[0];
      if(profile != null) {
        meshXML = profile.instance_mesh[0];
        if(meshXML != null) {
          daeMesh = document.findAlternativa3DObject(meshXML.@url[0]);
          daeMesh.parse();
          if(daeMesh != null) {
            daeMesh.applyA3DMeshProperties(mesh);
            daeObject.isSplitter = daeMesh.isSplitter;
            daeObject.isStaticGeometry = daeMesh.isBaseGeometry;
          } else {
            document.logger.logNotFoundError(meshXML.@url[0]);
          }
        }
      }
    }

    public function applyAnimation(param1:Object3D) : DaeObject {
      var local2:AnimationClip = this.parseAnimation(param1);
      if(local2 == null) {
        return new DaeObject(param1);
      }
      param1.name = this.animName;
      local2.attach(param1,false);
      return new DaeObject(param1,local2);
    }

    public function parseAnimation(param1:Object3D = null) : AnimationClip {
      if(this.channels == null || !this.hasTransformationAnimation()) {
        return null;
      }
      var local2:DaeChannel = this.getChannel(DaeChannel.PARAM_MATRIX);
      if(local2 != null) {
        return this.createClip(local2.tracks);
      }
      var local3:AnimationClip = new AnimationClip();
      var local4:Vector.<Vector3D> = param1 != null ? null : this.getMatrix().decompose();
      local2 = this.getChannel(DaeChannel.PARAM_TRANSLATE);
      if(local2 != null) {
        this.addTracksToClip(local3,local2.tracks);
      } else {
        local2 = this.getChannel(DaeChannel.PARAM_TRANSLATE_X);
        if(local2 != null) {
          this.addTracksToClip(local3,local2.tracks);
        } else {
          local3.addTrack(this.createValueStaticTrack("x",param1 == null ? local4[0].x : param1.x));
        }
        local2 = this.getChannel(DaeChannel.PARAM_TRANSLATE_Y);
        if(local2 != null) {
          this.addTracksToClip(local3,local2.tracks);
        } else {
          local3.addTrack(this.createValueStaticTrack("y",param1 == null ? local4[0].y : param1.y));
        }
        local2 = this.getChannel(DaeChannel.PARAM_TRANSLATE_Z);
        if(local2 != null) {
          this.addTracksToClip(local3,local2.tracks);
        } else {
          local3.addTrack(this.createValueStaticTrack("z",param1 == null ? local4[0].z : param1.z));
        }
      }
      local2 = this.getChannel(DaeChannel.PARAM_ROTATION_X);
      if(local2 != null) {
        this.addTracksToClip(local3,local2.tracks);
      } else {
        local3.addTrack(this.createValueStaticTrack("rotationX",param1 == null ? local4[1].x : param1.rotationX));
      }
      local2 = this.getChannel(DaeChannel.PARAM_ROTATION_Y);
      if(local2 != null) {
        this.addTracksToClip(local3,local2.tracks);
      } else {
        local3.addTrack(this.createValueStaticTrack("rotationY",param1 == null ? local4[1].y : param1.rotationY));
      }
      local2 = this.getChannel(DaeChannel.PARAM_ROTATION_Z);
      if(local2 != null) {
        this.addTracksToClip(local3,local2.tracks);
      } else {
        local3.addTrack(this.createValueStaticTrack("rotationZ",param1 == null ? local4[1].z : param1.rotationZ));
      }
      local2 = this.getChannel(DaeChannel.PARAM_SCALE);
      if(local2 != null) {
        this.addTracksToClip(local3,local2.tracks);
      } else {
        local2 = this.getChannel(DaeChannel.PARAM_SCALE_X);
        if(local2 != null) {
          this.addTracksToClip(local3,local2.tracks);
        } else {
          local3.addTrack(this.createValueStaticTrack("scaleX",param1 == null ? local4[2].x : param1.scaleX));
        }
        local2 = this.getChannel(DaeChannel.PARAM_SCALE_Y);
        if(local2 != null) {
          this.addTracksToClip(local3,local2.tracks);
        } else {
          local3.addTrack(this.createValueStaticTrack("scaleY",param1 == null ? local4[2].y : param1.scaleY));
        }
        local2 = this.getChannel(DaeChannel.PARAM_SCALE_Z);
        if(local2 != null) {
          this.addTracksToClip(local3,local2.tracks);
        } else {
          local3.addTrack(this.createValueStaticTrack("scaleZ",param1 == null ? local4[2].z : param1.scaleZ));
        }
      }
      if(local3.numTracks > 0) {
        return local3;
      }
      return null;
    }

    private function createClip(param1:Vector.<Track>) : AnimationClip {
      var local2:AnimationClip = new AnimationClip();
      var local3:int = 0;
      var local4:int = int(param1.length);
      while(local3 < local4) {
        local2.addTrack(param1[local3]);
        local3++;
      }
      return local2;
    }

    private function addTracksToClip(param1:AnimationClip, param2:Vector.<Track>) : void {
      var local3:int = 0;
      var local4:int = int(param2.length);
      while(local3 < local4) {
        param1.addTrack(param2[local3]);
        local3++;
      }
    }

    private function hasTransformationAnimation() : Boolean {
      var local3:DaeChannel = null;
      var local4:Boolean = false;
      var local1:int = 0;
      var local2:int = int(this.channels.length);
      while(local1 < local2) {
        local3 = this.channels[local1];
        local3.parse();
        local4 = local3.animatedParam == DaeChannel.PARAM_MATRIX;
        local4 ||= local3.animatedParam == DaeChannel.PARAM_TRANSLATE;
        local4 ||= local3.animatedParam == DaeChannel.PARAM_TRANSLATE_X;
        local4 ||= local3.animatedParam == DaeChannel.PARAM_TRANSLATE_Y;
        local4 ||= local3.animatedParam == DaeChannel.PARAM_TRANSLATE_Z;
        local4 ||= local3.animatedParam == DaeChannel.PARAM_ROTATION_X;
        local4 ||= local3.animatedParam == DaeChannel.PARAM_ROTATION_Y;
        local4 ||= local3.animatedParam == DaeChannel.PARAM_ROTATION_Z;
        local4 ||= local3.animatedParam == DaeChannel.PARAM_SCALE;
        local4 ||= local3.animatedParam == DaeChannel.PARAM_SCALE_X;
        local4 ||= local3.animatedParam == DaeChannel.PARAM_SCALE_Y;
        local4 ||= local3.animatedParam == DaeChannel.PARAM_SCALE_Z;
        if(local4) {
          return true;
        }
        local1++;
      }
      return false;
    }

    private function getChannel(param1:String) : DaeChannel {
      var local4:DaeChannel = null;
      var local2:int = 0;
      var local3:int = int(this.channels.length);
      while(local2 < local3) {
        local4 = this.channels[local2];
        local4.parse();
        if(local4.animatedParam == param1) {
          return local4;
        }
        local2++;
      }
      return null;
    }

    private function concatTracks(param1:Vector.<Track>, param2:Vector.<Track>) : void {
      var local3:int = 0;
      var local4:int = int(param1.length);
      while(local3 < local4) {
        param2.push(param1[local3]);
        local3++;
      }
    }

    private function createValueStaticTrack(param1:String, param2:Number) : Track {
      var local3:NumberTrack = new NumberTrack(this.animName,param1);
      local3.addKey(0,param2);
      return local3;
    }

    public function createStaticTransformTrack() : TransformTrack {
      var local1:TransformTrack = new TransformTrack(this.animName);
      local1.addKey(0,this.getMatrix());
      return local1;
    }

    public function get layer() : String {
      var local1:XML = data.@layer[0];
      return local1 == null ? null : local1.toString();
    }
  }
}
