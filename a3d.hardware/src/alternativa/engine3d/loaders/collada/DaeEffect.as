package alternativa.engine3d.loaders.collada {
  import alternativa.engine3d.materials.FillMaterial;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.materials.TextureMaterial;

  use namespace collada;

  public class DaeEffect extends DaeElement {
    private var effectParams:Object;
    private var commonParams:Object;
    private var techniqueParams:Object;
    private var diffuse:DaeEffectParam;
    private var emission:DaeEffectParam;
    private var transparent:DaeEffectParam;
    private var transparency:DaeEffectParam;

    public function DaeEffect(param1:XML, param2:DaeDocument) {
      super(param1,param2);
      this.constructImages();
    }

    private function constructImages() : void {
      var local2:XML = null;
      var local3:DaeImage = null;
      var local1:XMLList = data..image;
      for each(local2 in local1) {
        local3 = new DaeImage(local2,document);
        if(local3.id != null) {
          document.images[local3.id] = local3;
        }
      }
    }

    override protected function parseImplementation() : Boolean {
      var shader:XML;
      var element:XML = null;
      var param:DaeParam = null;
      var technique:XML = null;
      var transparentXML:XML = null;
      var transparencyXML:XML = null;
      var emissionXML:XML = null;
      var diffuseXML:XML = null;
      this.effectParams = new Object();
      for each(element in data.newparam) {
        param = new DaeParam(element,document);
        this.effectParams[param.sid] = param;
      }
      this.commonParams = new Object();
      for each(element in data.profile_COMMON.newparam) {
        param = new DaeParam(element,document);
        this.commonParams[param.sid] = param;
      }
      this.techniqueParams = new Object();
      technique = data.profile_COMMON.technique[0];
      if(technique != null) {
        for each(element in technique.newparam) {
          param = new DaeParam(element,document);
          this.techniqueParams[param.sid] = param;
        }
      }
      shader = data.profile_COMMON.technique.*.(localName() == "constant" || localName() == "lambert" || localName() == "phong" || localName() == "blinn")[0];
      if(shader != null) {
        if(shader.localName() == "constant") {
          emissionXML = shader.emission[0];
          if(emissionXML != null) {
            this.emission = new DaeEffectParam(emissionXML,this);
          }
        } else {
          diffuseXML = shader.diffuse[0];
          if(diffuseXML != null) {
            this.diffuse = new DaeEffectParam(diffuseXML,this);
          }
        }
        transparentXML = shader.transparent[0];
        if(transparentXML != null) {
          this.transparent = new DaeEffectParam(transparentXML,this);
        }
        transparencyXML = shader.transparency[0];
        if(transparencyXML != null) {
          this.transparency = new DaeEffectParam(transparencyXML,this);
        }
      }
      return true;
    }

    internal function getParam(param1:String, param2:Object) : DaeParam {
      var local3:DaeParam = param2[param1];
      if(local3 != null) {
        return local3;
      }
      local3 = this.techniqueParams[param1];
      if(local3 != null) {
        return local3;
      }
      local3 = this.commonParams[param1];
      if(local3 != null) {
        return local3;
      }
      return this.effectParams[param1];
    }

    private function float4ToUint(param1:Array, param2:Boolean = true) : uint {
      var local6:uint = 0;
      var local3:uint = param1[0] * 255;
      var local4:uint = param1[1] * 255;
      var local5:uint = param1[2] * 255;
      if(param2) {
        local6 = param1[3] * 255;
        return local6 << 24 | local3 << 16 | local4 << 8 | local5;
      }
      return local3 << 16 | local4 << 8 | local5;
    }

    public function getMaterial(param1:Object) : Material {
      var local3:Array = null;
      var local4:FillMaterial = null;
      var local5:Number = NaN;
      var local6:DaeImage = null;
      var local7:DaeParam = null;
      var local8:TextureMaterial = null;
      var local9:DaeImage = null;
      var local2:DaeEffectParam = this.diffuse != null ? this.diffuse : this.emission;
      if(local2 != null) {
        local3 = local2.getColor(param1);
        if(local3 != null) {
          local4 = new FillMaterial(this.float4ToUint(local3,false),local3[3]);
          if(this.transparency != null) {
            local5 = this.transparency.getFloat(param1);
            if(!isNaN(local5)) {
              local4.alpha = local5;
            }
          }
          return local4;
        }
        local6 = local2.getImage(param1);
        if(local6 != null) {
          local7 = local2.getSampler(param1);
          local8 = new TextureMaterial();
          local8.repeat = local7 == null ? true : local7.wrap_s == null || local7.wrap_s == "WRAP";
          local8.diffuseMapURL = local6.init_from;
          local9 = this.transparent == null ? null : this.transparent.getImage(param1);
          if(local9 != null) {
            local8.opacityMapURL = local9.init_from;
          }
          return local8;
        }
      }
      return null;
    }

    public function get diffuseTexCoords() : String {
      return this.diffuse == null && this.emission == null ? null : (this.diffuse != null ? this.diffuse.texCoord : this.emission.texCoord);
    }
  }
}
