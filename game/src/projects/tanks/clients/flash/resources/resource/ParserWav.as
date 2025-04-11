package projects.tanks.clients.flash.resources.resource {
  import flash.utils.ByteArray;
  import flash.utils.Endian;

  public class ParserWav {
    public function ParserWav() {
      super();
    }

    public function parse(param1:ByteArray, param2:int = 0, param3:Boolean = false) : Vector.<Number> {
      var local12:int = 0;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      if(param3) {
      }
      param1.position = 0;
      param1.endian = Endian.LITTLE_ENDIAN;
      var local4:ByteArray = new ByteArray();
      param1.readBytes(local4,0,4);
      if(local4.toString() != "RIFF") {
        throw new Error("Incorrect file header.");
      }
      param1.position = 16;
      if(param1.readUnsignedInt() != 16) {
        throw new Error("Incorrect file size.");
      }
      if(param1.readShort() <= 0) {
        throw new Error("Incorrect file format.");
      }
      var local5:int = param1.readShort();
      if(param3) {
      }
      if(local5 < 1 || local5 > 2) {
        throw new Error("Incorrect channels count.");
      }
      var local6:int = int(param1.readUnsignedInt());
      if(param3) {
      }
      if(local6 != 22050 && local6 != 44100) {
        throw new Error("Incorrect sample rate.");
      }
      var local7:int = int(param1.readUnsignedInt());
      if(param3) {
      }
      var local8:int = param1.readShort();
      if(param3) {
      }
      var local9:int = param1.readShort();
      if(param3) {
      }
      if(local9 != 16 && local9 != 32) {
        throw new Error("Incorrect bit depth.");
      }
      if(local8 <= 0) {
        local8 = local5 * local9 / 8;
        if(param3) {
        }
      }
      param1.position += 4;
      var local10:int = int(param1.readUnsignedInt());
      if(param1.bytesAvailable < local10) {
        local10 = int(param1.bytesAvailable);
      }
      param1.position = 44;
      var local11:int = local10 / local5 / (local9 / 8);
      if(param3) {
      }
      var local17:Vector.<Number> = new Vector.<Number>();
      var local18:int = 0;
      if(local6 == 22050) {
        param2 >>= 1;
      }
      local12 = 0;
      while(local12 < local11) {
        if(local5 == 1) {
          if(local9 == 16) {
            local13 = param1.readShort() / 32768;
          } else {
            local13 = param1.readInt() / 2147483648;
          }
          if(local12 < param2) {
            local13 *= local12 / param2;
          } else if(local12 >= local11 - param2) {
            local13 *= (local11 - local12 - 1) / param2;
          }
          local14 = local13;
        } else {
          if(local9 == 16) {
            local13 = param1.readShort() / 32768;
            local14 = param1.readShort() / 32768;
          } else {
            local13 = param1.readInt() / 2147483648;
            local14 = param1.readInt() / 2147483648;
          }
          if(local12 < param2) {
            local13 *= local12 / param2;
            local14 *= local12 / param2;
          } else if(local12 >= local11 - param2) {
            local13 *= (local11 - local12 - 1) / param2;
            local14 *= (local11 - local12 - 1) / param2;
          }
        }
        if(local6 == 22050) {
          if(local12 > 0) {
            local17[local18] = (local15 + local13) * 0.5;
            local18++;
            local17[local18] = (local16 + local14) * 0.5;
            local18++;
          }
          local15 = local13;
          local16 = local14;
        }
        local17[local18] = local13;
        local18++;
        local17[local18] = local14;
        local18++;
        local12++;
      }
      if(local6 == 22050) {
        local17[local18] = (local15 + local17[0]) * 0.5;
        local18++;
        local17[local18] = (local16 + local17[1]) * 0.5;
        local18++;
      }
      if(param3) {
      }
      return local17;
    }
  }
}
