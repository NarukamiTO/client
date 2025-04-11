package alternativa.engine3d.loaders.collada {
  import alternativa.engine3d.animation.keys.NumberTrack;
  import alternativa.engine3d.animation.keys.Track;
  import alternativa.engine3d.animation.keys.TransformTrack;
  import flash.geom.Matrix3D;

  use namespace collada;

  public class DaeSampler extends DaeElement {
    private var times:Vector.<Number>;
    private var values:Vector.<Number>;
    private var timesStride:int;
    private var valuesStride:int;

    public function DaeSampler(param1:XML, param2:DaeDocument) {
      super(param1,param2);
    }

    override protected function parseImplementation() : Boolean {
      var local2:DaeSource = null;
      var local3:DaeSource = null;
      var local6:DaeInput = null;
      var local7:String = null;
      var local1:XMLList = data.input;
      var local4:int = 0;
      var local5:int = int(local1.length());
      for(; local4 < local5; local4++) {
        local6 = new DaeInput(local1[local4],document);
        local7 = local6.semantic;
        if(local7 == null) {
          continue;
        }
        switch(local7) {
          case "INPUT":
            local2 = local6.prepareSource(1);
            if(local2 != null) {
              this.times = local2.numbers;
              this.timesStride = local2.stride;
            }
            break;
          case "OUTPUT":
            local3 = local6.prepareSource(1);
            if(local3 != null) {
              this.values = local3.numbers;
              this.valuesStride = local3.stride;
            }
            break;
        }
      }
      return true;
    }

    public function parseNumbersTrack(param1:String, param2:String) : NumberTrack {
      var local3:NumberTrack = null;
      var local4:int = 0;
      var local5:int = 0;
      if(this.times != null && this.values != null && this.timesStride > 0) {
        local3 = new NumberTrack(param1,param2);
        local4 = this.times.length / this.timesStride;
        local5 = 0;
        while(local5 < local4) {
          local3.addKey(this.times[int(this.timesStride * local5)],this.values[int(this.valuesStride * local5)]);
          local5++;
        }
        return local3;
      }
      return null;
    }

    public function parseTransformationTrack(param1:String) : Track {
      var local2:TransformTrack = null;
      var local3:int = 0;
      var local4:int = 0;
      var local5:int = 0;
      var local6:Matrix3D = null;
      if(this.times != null && this.values != null && this.timesStride != 0) {
        local2 = new TransformTrack(param1);
        local3 = this.times.length / this.timesStride;
        local4 = 0;
        while(local4 < local3) {
          local5 = this.valuesStride * local4;
          local6 = new Matrix3D(Vector.<Number>([this.values[local5],this.values[local5 + 4],this.values[local5 + 8],this.values[local5 + 12],this.values[local5 + 1],this.values[local5 + 5],this.values[local5 + 9],this.values[local5 + 13],this.values[local5 + 2],this.values[local5 + 6],this.values[local5 + 10],this.values[local5 + 14],this.values[local5 + 3],this.values[local5 + 7],this.values[local5 + 11],this.values[local5 + 15]]));
          local2.addKey(this.times[local4 * this.timesStride],local6);
          local4++;
        }
        return local2;
      }
      return null;
    }

    public function parsePointsTracks(param1:String, param2:String, param3:String, param4:String) : Vector.<Track> {
      var local5:NumberTrack = null;
      var local6:NumberTrack = null;
      var local7:NumberTrack = null;
      var local8:int = 0;
      var local9:int = 0;
      var local10:int = 0;
      var local11:Number = NaN;
      if(this.times != null && this.values != null && this.timesStride != 0) {
        local5 = new NumberTrack(param1,param2);
        local5.object = param1;
        local6 = new NumberTrack(param1,param3);
        local6.object = param1;
        local7 = new NumberTrack(param1,param4);
        local7.object = param1;
        local8 = this.times.length / this.timesStride;
        local9 = 0;
        while(local9 < local8) {
          local10 = local9 * this.valuesStride;
          local11 = this.times[local9 * this.timesStride];
          local5.addKey(local11,this.values[local10]);
          local6.addKey(local11,this.values[local10 + 1]);
          local7.addKey(local11,this.values[local10 + 2]);
          local9++;
        }
        return Vector.<Track>([local5,local6,local7]);
      }
      return null;
    }
  }
}
