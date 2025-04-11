package alternativa.engine3d.loaders.collada {
  use namespace collada;

  public class DaeParam extends DaeElement {
    public function DaeParam(param1:XML, param2:DaeDocument) {
      super(param1,param2);
    }

    public function get ref() : String {
      var local1:XML = data.@ref[0];
      return local1 == null ? null : local1.toString();
    }

    public function getFloat() : Number {
      var local1:XML = data.float[0];
      if(local1 != null) {
        return parseNumber(local1);
      }
      return NaN;
    }

    public function getFloat4() : Array {
      var local2:Array = null;
      var local1:XML = data.float4[0];
      if(local1 == null) {
        local1 = data.float3[0];
        if(local1 != null) {
          local2 = parseNumbersArray(local1);
          local2[3] = 1;
        }
      } else {
        local2 = parseNumbersArray(local1);
      }
      return local2;
    }

    public function get surfaceSID() : String {
      var local1:XML = data.sampler2D.source[0];
      return local1 == null ? null : local1.text().toString();
    }

    public function get wrap_s() : String {
      var local1:XML = data.sampler2D.wrap_s[0];
      return local1 == null ? null : local1.text().toString();
    }

    public function get image() : DaeImage {
      var local2:DaeImage = null;
      var local3:XML = null;
      var local4:XML = null;
      var local1:XML = data.surface[0];
      if(local1 != null) {
        local3 = local1.init_from[0];
        if(local3 == null) {
          return null;
        }
        local2 = document.findImageByID(local3.text().toString());
      } else {
        local4 = data.instance_image.@url[0];
        if(local4 == null) {
          return null;
        }
        local2 = document.findImage(local4);
      }
      return local2;
    }
  }
}
