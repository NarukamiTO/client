package alternativa.engine3d.loaders.collada {
  import alternativa.engine3d.alternativa3d;

  use namespace collada;
  use namespace alternativa3d;
  use namespace daeAlternativa3DLibrary;

  public class DaeDocument {
    public var scene:DaeVisualScene;

    private var data:XML;

    internal var sources:Object;
    internal var arrays:Object;
    internal var vertices:Object;
    internal var geometries:Object;
    internal var nodes:Object;
    internal var lights:Object;
    internal var images:Object;
    internal var effects:Object;
    internal var controllers:Object;
    internal var samplers:Object;
    internal var alternativa3DObjects:Object;

    public var materials:Object;

    internal var logger:DaeLogger;

    public var versionMajor:uint;
    public var versionMinor:uint;
    public var alternativa3DExtensionVersionMajor:uint = 0;
    public var alternativa3DExtensionVersionMinor:uint = 0;

    public function DaeDocument(param1:XML) {
      super();
      this.data = param1;
      var local2:Array = this.data.@version[0].toString().split(/[.,]/);
      this.versionMajor = parseInt(local2[1],10);
      this.versionMinor = parseInt(local2[2],10);
      this.logger = new DaeLogger();
      this.constructStructures();
      this.constructScenes();
      this.registerInstanceControllers();
      this.constructAnimations();
      this.constructAlternativa3DObjects();
    }

    private function getLocalID(param1:XML) : String {
      var local2:String = param1.toString();
      if(local2.charAt(0) == "#") {
        return local2.substr(1);
      }
      this.logger.logExternalError(param1);
      return null;
    }

    private function constructStructures() : void {
      var local1:XML = null;
      var local2:DaeSource = null;
      var local3:DaeLight = null;
      var local4:DaeImage = null;
      var local5:DaeEffect = null;
      var local6:DaeMaterial = null;
      var local7:DaeGeometry = null;
      var local8:DaeController = null;
      var local9:DaeNode = null;
      this.sources = new Object();
      this.arrays = new Object();
      for each(local1 in this.data..source) {
        local2 = new DaeSource(local1,this);
        if(local2.id != null) {
          this.sources[local2.id] = local2;
        }
      }
      this.lights = new Object();
      for each(local1 in this.data.library_lights.light) {
        local3 = new DaeLight(local1,this);
        if(local3.id != null) {
          this.lights[local3.id] = local3;
        }
      }
      this.images = new Object();
      for each(local1 in this.data.library_images.image) {
        local4 = new DaeImage(local1,this);
        if(local4.id != null) {
          this.images[local4.id] = local4;
        }
      }
      this.effects = new Object();
      for each(local1 in this.data.library_effects.effect) {
        local5 = new DaeEffect(local1,this);
        if(local5.id != null) {
          this.effects[local5.id] = local5;
        }
      }
      this.materials = new Object();
      for each(local1 in this.data.library_materials.material) {
        local6 = new DaeMaterial(local1,this);
        if(local6.id != null) {
          this.materials[local6.id] = local6;
        }
      }
      this.geometries = new Object();
      this.vertices = new Object();
      for each(local1 in this.data.library_geometries.geometry) {
        local7 = new DaeGeometry(local1,this);
        if(local7.id != null) {
          this.geometries[local7.id] = local7;
        }
      }
      this.controllers = new Object();
      for each(local1 in this.data.library_controllers.controller) {
        local8 = new DaeController(local1,this);
        if(local8.id != null) {
          this.controllers[local8.id] = local8;
        }
      }
      this.nodes = new Object();
      for each(local1 in this.data.library_nodes.node) {
        local9 = new DaeNode(local1,this);
        if(local9.id != null) {
          this.nodes[local9.id] = local9;
        }
      }
    }

    private function constructScenes() : void {
      var local3:XML = null;
      var local4:DaeVisualScene = null;
      var local1:XML = this.data.scene.instance_visual_scene.@url[0];
      var local2:String = this.getLocalID(local1);
      for each(local3 in this.data.library_visual_scenes.visual_scene) {
        local4 = new DaeVisualScene(local3,this);
        if(local4.id == local2) {
          this.scene = local4;
        }
      }
      if(local2 != null && this.scene == null) {
        this.logger.logNotFoundError(local1);
      }
    }

    private function registerInstanceControllers() : void {
      var local1:int = 0;
      var local2:int = 0;
      if(this.scene != null) {
        local1 = 0;
        local2 = int(this.scene.nodes.length);
        while(local1 < local2) {
          this.scene.nodes[local1].registerInstanceControllers();
          local1++;
        }
      }
    }

    private function constructAnimations() : void {
      var local1:XML = null;
      var local2:DaeSampler = null;
      var local3:DaeChannel = null;
      var local4:DaeNode = null;
      this.samplers = new Object();
      for each(local1 in this.data.library_animations..sampler) {
        local2 = new DaeSampler(local1,this);
        if(local2.id != null) {
          this.samplers[local2.id] = local2;
        }
      }
      for each(local1 in this.data.library_animations..channel) {
        local3 = new DaeChannel(local1,this);
        local4 = local3.node;
        if(local4 != null) {
          local4.addChannel(local3);
        }
      }
    }

    private function constructAlternativa3DObjects() : void {
      var alternativa3dXML:XML = null;
      var versionComponents:Array = null;
      var element:XML = null;
      var object:DaeAlternativa3DObject = null;
      this.alternativa3DObjects = new Object();
      alternativa3dXML = this.data.extra.technique.(@profile = "Alternativa3D").library[0];
      if(alternativa3dXML != null) {
        versionComponents = alternativa3dXML.version[0].text().toString().split(/[.,]/);
        this.alternativa3DExtensionVersionMajor = parseInt(versionComponents[0],10);
        this.alternativa3DExtensionVersionMinor = parseInt(versionComponents[1],10);
        for each(element in alternativa3dXML.library_containers.children()) {
          object = new DaeAlternativa3DObject(element,this);
          if(object.id != null) {
            this.alternativa3DObjects[object.id] = object;
          }
        }
        for each(element in alternativa3dXML.library_sprites.sprite) {
          object = new DaeAlternativa3DObject(element,this);
          if(object.id != null) {
            this.alternativa3DObjects[object.id] = object;
          }
        }
        for each(element in alternativa3dXML.library_lods.lod) {
          object = new DaeAlternativa3DObject(element,this);
          if(object.id != null) {
            this.alternativa3DObjects[object.id] = object;
          }
        }
        for each(element in alternativa3dXML.library_meshes.mesh) {
          object = new DaeAlternativa3DObject(element,this);
          if(object.id != null) {
            this.alternativa3DObjects[object.id] = object;
          }
        }
      } else {
        this.alternativa3DExtensionVersionMajor = this.alternativa3DExtensionVersionMinor = 0;
      }
    }

    public function findArray(param1:XML) : DaeArray {
      return this.arrays[this.getLocalID(param1)];
    }

    public function findSource(param1:XML) : DaeSource {
      return this.sources[this.getLocalID(param1)];
    }

    public function findLight(param1:XML) : DaeLight {
      return this.lights[this.getLocalID(param1)];
    }

    public function findImage(param1:XML) : DaeImage {
      return this.images[this.getLocalID(param1)];
    }

    public function findImageByID(param1:String) : DaeImage {
      return this.images[param1];
    }

    public function findEffect(param1:XML) : DaeEffect {
      return this.effects[this.getLocalID(param1)];
    }

    public function findMaterial(param1:XML) : DaeMaterial {
      return this.materials[this.getLocalID(param1)];
    }

    public function findVertices(param1:XML) : DaeVertices {
      return this.vertices[this.getLocalID(param1)];
    }

    public function findGeometry(param1:XML) : DaeGeometry {
      return this.geometries[this.getLocalID(param1)];
    }

    public function findNode(param1:XML) : DaeNode {
      return this.nodes[this.getLocalID(param1)];
    }

    public function findNodeByID(param1:String) : DaeNode {
      return this.nodes[param1];
    }

    public function findController(param1:XML) : DaeController {
      return this.controllers[this.getLocalID(param1)];
    }

    public function findSampler(param1:XML) : DaeSampler {
      return this.samplers[this.getLocalID(param1)];
    }

    public function findAlternativa3DObject(param1:XML) : DaeAlternativa3DObject {
      return this.alternativa3DObjects[this.getLocalID(param1)];
    }
  }
}
