package alternativa.engine3d.loaders.collada {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.animation.keys.NumberKey;
  import alternativa.engine3d.animation.keys.NumberTrack;
  import alternativa.engine3d.animation.keys.Track;

  use namespace alternativa3d;

  public class DaeChannel extends DaeElement {
    public static const PARAM_UNDEFINED:String = "undefined";
    public static const PARAM_TRANSLATE_X:String = "x";
    public static const PARAM_TRANSLATE_Y:String = "y";
    public static const PARAM_TRANSLATE_Z:String = "z";
    public static const PARAM_SCALE_X:String = "scaleX";
    public static const PARAM_SCALE_Y:String = "scaleY";
    public static const PARAM_SCALE_Z:String = "scaleZ";
    public static const PARAM_ROTATION_X:String = "rotationX";
    public static const PARAM_ROTATION_Y:String = "rotationY";
    public static const PARAM_ROTATION_Z:String = "rotationZ";
    public static const PARAM_TRANSLATE:String = "translate";
    public static const PARAM_SCALE:String = "scale";
    public static const PARAM_MATRIX:String = "matrix";

    public var tracks:Vector.<Track>;
    public var animatedParam:String = "undefined";
    public var animName:String;

    public function DaeChannel(param1:XML, param2:DaeDocument) {
      super(param1,param2);
    }

    public function get node() : DaeNode {
      var local2:Array = null;
      var local3:DaeNode = null;
      var local4:int = 0;
      var local5:int = 0;
      var local6:String = null;
      var local1:XML = data.@target[0];
      if(local1 != null) {
        local2 = local1.toString().split("/");
        local3 = document.findNodeByID(local2[0]);
        if(local3 != null) {
          local2.pop();
          local4 = 1;
          local5 = int(local2.length);
          while(local4 < local5) {
            local6 = local2[local4];
            local3 = local3.getNodeBySid(local6);
            if(local3 == null) {
              return null;
            }
            local4++;
          }
          return local3;
        }
      }
      return null;
    }

    override protected function parseImplementation() : Boolean {
      this.parseTransformationType();
      this.parseSampler();
      return true;
    }

    private function parseTransformationType() : void {
      var local6:XML = null;
      var local12:XML = null;
      var local13:XML = null;
      var local14:String = null;
      var local15:Array = null;
      var local1:XML = data.@target[0];
      if(local1 == null) {
        return;
      }
      var local2:Array = local1.toString().split("/");
      var local3:String = local2.pop();
      var local4:Array = local3.split(".");
      var local5:int = int(local4.length);
      var local7:DaeNode = this.node;
      if(local7 == null) {
        return;
      }
      this.animName = local7.animName;
      var local8:XMLList = local7.data.children();
      var local9:int = 0;
      var local10:int = int(local8.length());
      while(local9 < local10) {
        local12 = local8[local9];
        local13 = local12.@sid[0];
        if(local13 != null && local13.toString() == local4[0]) {
          local6 = local12;
          break;
        }
        local9++;
      }
      var local11:String = local6 != null ? local6.localName() as String : null;
      if(local5 > 1) {
        local14 = local4[1];
        switch(local11) {
          case "translate":
            switch(local14) {
              case "X":
                this.animatedParam = PARAM_TRANSLATE_X;
                break;
              case "Y":
                this.animatedParam = PARAM_TRANSLATE_Y;
                break;
              case "Z":
                this.animatedParam = PARAM_TRANSLATE_Z;
            }
            break;
          case "rotate":
            local15 = parseNumbersArray(local6);
            switch(local15.indexOf(1)) {
              case 0:
                this.animatedParam = PARAM_ROTATION_X;
                break;
              case 1:
                this.animatedParam = PARAM_ROTATION_Y;
                break;
              case 2:
                this.animatedParam = PARAM_ROTATION_Z;
            }
            break;
          case "scale":
            switch(local14) {
              case "X":
                this.animatedParam = PARAM_SCALE_X;
                break;
              case "Y":
                this.animatedParam = PARAM_SCALE_Y;
                break;
              case "Z":
                this.animatedParam = PARAM_SCALE_Z;
            }
        }
      } else {
        switch(local11) {
          case "translate":
            this.animatedParam = PARAM_TRANSLATE;
            break;
          case "scale":
            this.animatedParam = PARAM_SCALE;
            break;
          case "matrix":
            this.animatedParam = PARAM_MATRIX;
        }
      }
    }

    private function parseSampler() : void {
      var local2:NumberTrack = null;
      var local3:Number = NaN;
      var local4:NumberKey = null;
      var local1:DaeSampler = document.findSampler(data.@source[0]);
      if(local1 != null) {
        local1.parse();
        if(this.animatedParam == PARAM_MATRIX) {
          this.tracks = Vector.<Track>([local1.parseTransformationTrack(this.animName)]);
          return;
        }
        if(this.animatedParam == PARAM_TRANSLATE) {
          this.tracks = local1.parsePointsTracks(this.animName,"x","y","z");
          return;
        }
        if(this.animatedParam == PARAM_SCALE) {
          this.tracks = local1.parsePointsTracks(this.animName,"scaleX","scaleY","scaleZ");
          return;
        }
        if(this.animatedParam == PARAM_ROTATION_X || this.animatedParam == PARAM_ROTATION_Y || this.animatedParam == PARAM_ROTATION_Z) {
          local2 = local1.parseNumbersTrack(this.animName,this.animatedParam);
          local3 = Math.PI / 180;
          local4 = local2.alternativa3d::keyList;
          while(local4 != null) {
            local4.alternativa3d::_value *= local3;
            local4 = local4.alternativa3d::next;
          }
          this.tracks = Vector.<Track>([local2]);
          return;
        }
        if(this.animatedParam == PARAM_TRANSLATE_X || this.animatedParam == PARAM_TRANSLATE_Y || this.animatedParam == PARAM_TRANSLATE_Z || this.animatedParam == PARAM_SCALE_X || this.animatedParam == PARAM_SCALE_Y || this.animatedParam == PARAM_SCALE_Z) {
          this.tracks = Vector.<Track>([local1.parseNumbersTrack(this.animName,this.animatedParam)]);
        }
      } else {
        document.logger.logNotFoundError(data.@source[0]);
      }
    }
  }
}
