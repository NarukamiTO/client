package alternativa.engine3d.loaders.collada {
  use namespace collada;

  public class DaeEffectParam extends DaeElement {
    private var effect:DaeEffect;

    public function DaeEffectParam(param1:XML, param2:DaeEffect) {
      super(param1,param2.document);
      this.effect = param2;
    }

    public function getFloat(param1:Object) : Number {
      var local4:DaeParam = null;
      var local2:XML = data.float[0];
      if(local2 != null) {
        return parseNumber(local2);
      }
      var local3:XML = data.param.@ref[0];
      if(local3 != null) {
        local4 = this.effect.getParam(local3.toString(),param1);
        if(local4 != null) {
          return local4.getFloat();
        }
      }
      return NaN;
    }

    public function getColor(param1:Object) : Array {
      var local4:DaeParam = null;
      var local2:XML = data.color[0];
      if(local2 != null) {
        return parseNumbersArray(local2);
      }
      var local3:XML = data.param.@ref[0];
      if(local3 != null) {
        local4 = this.effect.getParam(local3.toString(),param1);
        if(local4 != null) {
          return local4.getFloat4();
        }
      }
      return null;
    }

    private function get texture() : String {
      var local1:XML = data.texture.@texture[0];
      return local1 == null ? null : local1.toString();
    }

    public function getSampler(param1:Object) : DaeParam {
      var local2:String = this.texture;
      if(local2 != null) {
        return this.effect.getParam(local2,param1);
      }
      return null;
    }

    public function getImage(param1:Object) : DaeImage {
      var local3:String = null;
      var local4:DaeParam = null;
      var local2:DaeParam = this.getSampler(param1);
      if(local2 != null) {
        local3 = local2.surfaceSID;
        if(local3 != null) {
          local4 = this.effect.getParam(local3,param1);
          if(local4 != null) {
            return local4.image;
          }
          return null;
        }
        return local2.image;
      }
      return document.findImageByID(this.texture);
    }

    public function get texCoord() : String {
      var local1:XML = data.texture.@texcoord[0];
      return local1 == null ? null : local1.toString();
    }
  }
}
