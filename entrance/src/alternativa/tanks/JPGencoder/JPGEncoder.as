package alternativa.tanks.JPGencoder {
  import flash.display.*;
  import flash.utils.*;

  public class JPGEncoder {
    private var ZigZag:Array = [0,1,5,6,14,15,27,28,2,4,7,13,16,26,29,42,3,8,12,17,25,30,41,43,9,11,18,24,31,40,44,53,10,19,23,32,39,45,52,54,20,22,33,38,46,51,55,60,21,34,37,47,50,56,59,61,35,36,48,49,57,58,62,63];
    private var YTable:Array = new Array(64);
    private var UVTable:Array = new Array(64);
    private var fdtbl_Y:Array = new Array(64);
    private var fdtbl_UV:Array = new Array(64);
    private var YDC_HT:Array;
    private var UVDC_HT:Array;
    private var YAC_HT:Array;
    private var UVAC_HT:Array;
    private var std_dc_luminance_nrcodes:Array = [0,0,1,5,1,1,1,1,1,1,0,0,0,0,0,0,0];
    private var std_dc_luminance_values:Array = [0,1,2,3,4,5,6,7,8,9,10,11];
    private var std_ac_luminance_nrcodes:Array = [0,0,2,1,3,3,2,4,3,5,5,4,4,0,0,1,125];
    private var std_ac_luminance_values:Array = [1,2,3,0,4,17,5,18,33,49,65,6,19,81,97,7,34,113,20,50,129,145,161,8,35,66,177,193,21,82,209,240,36,51,98,114,130,9,10,22,23,24,25,26,37,38,39,40,41,42,52,53,54,55,56,57,58,67,68,69,70,71,72,73,74,83,84,85,86,87,88,89,90,99,100,101,102,103,104,105,106,115,116,117,118,119,120,121,122,131,132,133,134,135,136,137,138,146,147,148,149,150,151,152,153,154,162,163,164,165,166,167,168,169,170,178,179,180,181,182,183,184,185,186,194,195,196,197,198,199,200,201,202,210,211,212,213,214,215,216,217,218,225,226,227,228,229,230,231,232,233,234,241,242,243,244,245,246,247,248,249,250];
    private var std_dc_chrominance_nrcodes:Array = [0,0,3,1,1,1,1,1,1,1,1,1,0,0,0,0,0];
    private var std_dc_chrominance_values:Array = [0,1,2,3,4,5,6,7,8,9,10,11];
    private var std_ac_chrominance_nrcodes:Array = [0,0,2,1,2,4,4,3,4,7,5,4,4,0,1,2,119];
    private var std_ac_chrominance_values:Array = [0,1,2,3,17,4,5,33,49,6,18,65,81,7,97,113,19,34,50,129,8,20,66,145,161,177,193,9,35,51,82,240,21,98,114,209,10,22,36,52,225,37,241,23,24,25,26,38,39,40,41,42,53,54,55,56,57,58,67,68,69,70,71,72,73,74,83,84,85,86,87,88,89,90,99,100,101,102,103,104,105,106,115,116,117,118,119,120,121,122,130,131,132,133,134,135,136,137,138,146,147,148,149,150,151,152,153,154,162,163,164,165,166,167,168,169,170,178,179,180,181,182,183,184,185,186,194,195,196,197,198,199,200,201,202,210,211,212,213,214,215,216,217,218,226,227,228,229,230,231,232,233,234,242,243,244,245,246,247,248,249,250];
    private var bitcode:Array = new Array(65535);
    private var category:Array = new Array(65535);
    private var byteout:ByteArray;
    private var bytenew:int = 0;
    private var bytepos:int = 7;
    private var DU:Array = new Array(64);
    private var YDU:Array = new Array(64);
    private var UDU:Array = new Array(64);
    private var VDU:Array = new Array(64);
    private var image:BitmapData;
    private var DCY:Number = 0;
    private var DCU:Number = 0;
    private var DCV:Number = 0;
    private var xpos:int = 0;
    private var ypos:int = 0;

    public function JPGEncoder(param1:Number = 50) {
      super();
      if(param1 <= 0) {
        param1 = 1;
      }
      if(param1 > 100) {
        param1 = 100;
      }
      var local2:int = 0;
      if(param1 < 50) {
        local2 = int(5000 / param1);
      } else {
        local2 = int(200 - param1 * 2);
      }
      this.initHuffmanTbl();
      this.initCategoryNumber();
      this.initQuantTables(local2);
    }

    private function initQuantTables(param1:int) : void {
      var local2:int = 0;
      var local3:Number = NaN;
      var local8:int = 0;
      var local4:Array = [16,11,10,16,24,40,51,61,12,12,14,19,26,58,60,55,14,13,16,24,40,57,69,56,14,17,22,29,51,87,80,62,18,22,37,56,68,109,103,77,24,35,55,64,81,104,113,92,49,64,78,87,103,121,120,101,72,92,95,98,112,100,103,99];
      local2 = 0;
      while(local2 < 64) {
        local3 = Math.floor((local4[local2] * param1 + 50) / 100);
        if(local3 < 1) {
          local3 = 1;
        } else if(local3 > 255) {
          local3 = 255;
        }
        this.YTable[this.ZigZag[local2]] = local3;
        local2++;
      }
      var local5:Array = [17,18,24,47,99,99,99,99,18,21,26,66,99,99,99,99,24,26,56,99,99,99,99,99,47,66,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99];
      local2 = 0;
      while(local2 < 64) {
        local3 = Math.floor((local5[local2] * param1 + 50) / 100);
        if(local3 < 1) {
          local3 = 1;
        } else if(local3 > 255) {
          local3 = 255;
        }
        this.UVTable[this.ZigZag[local2]] = local3;
        local2++;
      }
      var local6:Array = [1,1.387039845,1.306562965,1.175875602,1,0.785694958,0.5411961,0.275899379];
      local2 = 0;
      var local7:int = 0;
      while(local7 < 8) {
        local8 = 0;
        while(local8 < 8) {
          this.fdtbl_Y[local2] = 1 / (this.YTable[this.ZigZag[local2]] * local6[local7] * local6[local8] * 8);
          this.fdtbl_UV[local2] = 1 / (this.UVTable[this.ZigZag[local2]] * local6[local7] * local6[local8] * 8);
          local2++;
          local8++;
        }
        local7++;
      }
    }

    private function computeHuffmanTbl(param1:Array, param2:Array) : Array {
      var local7:int = 0;
      var local3:int = 0;
      var local4:int = 0;
      var local5:Array = new Array();
      var local6:int = 1;
      while(local6 <= 16) {
        local7 = 1;
        while(local7 <= param1[local6]) {
          local5[param2[local4]] = new BitString();
          local5[param2[local4]].val = local3;
          local5[param2[local4]].len = local6;
          local4++;
          local3++;
          local7++;
        }
        local3 *= 2;
        local6++;
      }
      return local5;
    }

    private function initHuffmanTbl() : void {
      this.YDC_HT = this.computeHuffmanTbl(this.std_dc_luminance_nrcodes,this.std_dc_luminance_values);
      this.UVDC_HT = this.computeHuffmanTbl(this.std_dc_chrominance_nrcodes,this.std_dc_chrominance_values);
      this.YAC_HT = this.computeHuffmanTbl(this.std_ac_luminance_nrcodes,this.std_ac_luminance_values);
      this.UVAC_HT = this.computeHuffmanTbl(this.std_ac_chrominance_nrcodes,this.std_ac_chrominance_values);
    }

    private function initCategoryNumber() : void {
      var local3:int = 0;
      var local1:int = 1;
      var local2:int = 2;
      var local4:int = 1;
      while(local4 <= 15) {
        local3 = local1;
        while(local3 < local2) {
          this.category[32767 + local3] = local4;
          this.bitcode[32767 + local3] = new BitString();
          this.bitcode[32767 + local3].len = local4;
          this.bitcode[32767 + local3].val = local3;
          local3++;
        }
        local3 = -(local2 - 1);
        while(local3 <= -local1) {
          this.category[32767 + local3] = local4;
          this.bitcode[32767 + local3] = new BitString();
          this.bitcode[32767 + local3].len = local4;
          this.bitcode[32767 + local3].val = local2 - 1 + local3;
          local3++;
        }
        local1 <<= 1;
        local2 <<= 1;
        local4++;
      }
    }

    private function writeBits(param1:BitString) : void {
      var local2:int = param1.val;
      var local3:int = param1.len - 1;
      while(local3 >= 0) {
        if(Boolean(local2 & uint(1 << local3))) {
          this.bytenew |= uint(1 << this.bytepos);
        }
        local3--;
        --this.bytepos;
        if(this.bytepos < 0) {
          if(this.bytenew == 255) {
            this.writeByte(255);
            this.writeByte(0);
          } else {
            this.writeByte(this.bytenew);
          }
          this.bytepos = 7;
          this.bytenew = 0;
        }
      }
    }

    private function writeByte(param1:int) : void {
      this.byteout.writeByte(param1);
    }

    private function writeWord(param1:int) : void {
      this.writeByte(param1 >> 8 & 0xFF);
      this.writeByte(param1 & 0xFF);
    }

    private function fDCTQuant(param1:Array, param2:Array) : Array {
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:int = 0;
      var local23:int = 0;
      local22 = 0;
      while(local22 < 8) {
        local3 = param1[local23 + 0] + param1[local23 + 7];
        local10 = param1[local23 + 0] - param1[local23 + 7];
        local4 = param1[local23 + 1] + param1[local23 + 6];
        local9 = param1[local23 + 1] - param1[local23 + 6];
        local5 = param1[local23 + 2] + param1[local23 + 5];
        local8 = param1[local23 + 2] - param1[local23 + 5];
        local6 = param1[local23 + 3] + param1[local23 + 4];
        local7 = param1[local23 + 3] - param1[local23 + 4];
        local11 = local3 + local6;
        local14 = local3 - local6;
        local12 = local4 + local5;
        local13 = local4 - local5;
        param1[local23 + 0] = local11 + local12;
        param1[local23 + 4] = local11 - local12;
        local15 = (local13 + local14) * 0.707106781;
        param1[local23 + 2] = local14 + local15;
        param1[local23 + 6] = local14 - local15;
        local11 = local7 + local8;
        local12 = local8 + local9;
        local13 = local9 + local10;
        local19 = (local11 - local13) * 0.382683433;
        local16 = 0.5411961 * local11 + local19;
        local18 = 1.306562965 * local13 + local19;
        local17 = local12 * 0.707106781;
        local20 = local10 + local17;
        local21 = local10 - local17;
        param1[local23 + 5] = local21 + local16;
        param1[local23 + 3] = local21 - local16;
        param1[local23 + 1] = local20 + local18;
        param1[local23 + 7] = local20 - local18;
        local23 += 8;
        local22++;
      }
      local23 = 0;
      local22 = 0;
      while(local22 < 8) {
        local3 = param1[local23 + 0] + param1[local23 + 56];
        local10 = param1[local23 + 0] - param1[local23 + 56];
        local4 = param1[local23 + 8] + param1[local23 + 48];
        local9 = param1[local23 + 8] - param1[local23 + 48];
        local5 = param1[local23 + 16] + param1[local23 + 40];
        local8 = param1[local23 + 16] - param1[local23 + 40];
        local6 = param1[local23 + 24] + param1[local23 + 32];
        local7 = param1[local23 + 24] - param1[local23 + 32];
        local11 = local3 + local6;
        local14 = local3 - local6;
        local12 = local4 + local5;
        local13 = local4 - local5;
        param1[local23 + 0] = local11 + local12;
        param1[local23 + 32] = local11 - local12;
        local15 = (local13 + local14) * 0.707106781;
        param1[local23 + 16] = local14 + local15;
        param1[local23 + 48] = local14 - local15;
        local11 = local7 + local8;
        local12 = local8 + local9;
        local13 = local9 + local10;
        local19 = (local11 - local13) * 0.382683433;
        local16 = 0.5411961 * local11 + local19;
        local18 = 1.306562965 * local13 + local19;
        local17 = local12 * 0.707106781;
        local20 = local10 + local17;
        local21 = local10 - local17;
        param1[local23 + 40] = local21 + local16;
        param1[local23 + 24] = local21 - local16;
        param1[local23 + 8] = local20 + local18;
        param1[local23 + 56] = local20 - local18;
        local23++;
        local22++;
      }
      local22 = 0;
      while(local22 < 64) {
        param1[local22] = Math.round(param1[local22] * param2[local22]);
        local22++;
      }
      return param1;
    }

    private function writeAPP0() : void {
      this.writeWord(65504);
      this.writeWord(16);
      this.writeByte(74);
      this.writeByte(70);
      this.writeByte(73);
      this.writeByte(70);
      this.writeByte(0);
      this.writeByte(1);
      this.writeByte(1);
      this.writeByte(0);
      this.writeWord(1);
      this.writeWord(1);
      this.writeByte(0);
      this.writeByte(0);
    }

    private function writeSOF0(param1:int, param2:int) : void {
      this.writeWord(65472);
      this.writeWord(17);
      this.writeByte(8);
      this.writeWord(param2);
      this.writeWord(param1);
      this.writeByte(3);
      this.writeByte(1);
      this.writeByte(17);
      this.writeByte(0);
      this.writeByte(2);
      this.writeByte(17);
      this.writeByte(1);
      this.writeByte(3);
      this.writeByte(17);
      this.writeByte(1);
    }

    private function writeDQT() : void {
      var local1:int = 0;
      this.writeWord(65499);
      this.writeWord(132);
      this.writeByte(0);
      local1 = 0;
      while(local1 < 64) {
        this.writeByte(this.YTable[local1]);
        local1++;
      }
      this.writeByte(1);
      local1 = 0;
      while(local1 < 64) {
        this.writeByte(this.UVTable[local1]);
        local1++;
      }
    }

    private function writeDHT() : void {
      var local1:int = 0;
      this.writeWord(65476);
      this.writeWord(418);
      this.writeByte(0);
      local1 = 0;
      while(local1 < 16) {
        this.writeByte(this.std_dc_luminance_nrcodes[local1 + 1]);
        local1++;
      }
      local1 = 0;
      while(local1 <= 11) {
        this.writeByte(this.std_dc_luminance_values[local1]);
        local1++;
      }
      this.writeByte(16);
      local1 = 0;
      while(local1 < 16) {
        this.writeByte(this.std_ac_luminance_nrcodes[local1 + 1]);
        local1++;
      }
      local1 = 0;
      while(local1 <= 161) {
        this.writeByte(this.std_ac_luminance_values[local1]);
        local1++;
      }
      this.writeByte(1);
      local1 = 0;
      while(local1 < 16) {
        this.writeByte(this.std_dc_chrominance_nrcodes[local1 + 1]);
        local1++;
      }
      local1 = 0;
      while(local1 <= 11) {
        this.writeByte(this.std_dc_chrominance_values[local1]);
        local1++;
      }
      this.writeByte(17);
      local1 = 0;
      while(local1 < 16) {
        this.writeByte(this.std_ac_chrominance_nrcodes[local1 + 1]);
        local1++;
      }
      local1 = 0;
      while(local1 <= 161) {
        this.writeByte(this.std_ac_chrominance_values[local1]);
        local1++;
      }
    }

    private function writeSOS() : void {
      this.writeWord(65498);
      this.writeWord(12);
      this.writeByte(3);
      this.writeByte(1);
      this.writeByte(0);
      this.writeByte(2);
      this.writeByte(17);
      this.writeByte(3);
      this.writeByte(17);
      this.writeByte(0);
      this.writeByte(63);
      this.writeByte(0);
    }

    private function processDU(param1:Array, param2:Array, param3:Number, param4:Array, param5:Array) : Number {
      var local8:int = 0;
      var local12:int = 0;
      var local13:int = 0;
      var local14:int = 0;
      var local6:BitString = param5[0];
      var local7:BitString = param5[240];
      var local9:Array = this.fDCTQuant(param1,param2);
      local8 = 0;
      while(local8 < 64) {
        this.DU[this.ZigZag[local8]] = local9[local8];
        local8++;
      }
      var local10:int = this.DU[0] - param3;
      param3 = Number(this.DU[0]);
      if(local10 == 0) {
        this.writeBits(param4[0]);
      } else {
        this.writeBits(param4[this.category[32767 + local10]]);
        this.writeBits(this.bitcode[32767 + local10]);
      }
      var local11:int = 63;
      while(local11 > 0 && this.DU[local11] == 0) {
        local11--;
      }
      if(local11 == 0) {
        this.writeBits(local6);
        return param3;
      }
      local8 = 1;
      while(local8 <= local11) {
        local12 = local8;
        while(this.DU[local8] == 0 && local8 <= local11) {
          local8++;
        }
        local13 = local8 - local12;
        if(local13 >= 16) {
          local14 = 1;
          while(local14 <= local13 / 16) {
            this.writeBits(local7);
            local14++;
          }
          local13 = int(local13 & 0x0F);
        }
        this.writeBits(param5[local13 * 16 + this.category[32767 + this.DU[local8]]]);
        this.writeBits(this.bitcode[32767 + this.DU[local8]]);
        local8++;
      }
      if(local11 != 63) {
        this.writeBits(local6);
      }
      return param3;
    }

    private function RGB2YUV(param1:BitmapData, param2:int, param3:int) : void {
      var local6:int = 0;
      var local7:uint = 0;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local4:int = 0;
      var local5:int = 0;
      while(local5 < 8) {
        local6 = 0;
        while(local6 < 8) {
          local7 = param1.getPixel32(param2 + local6,param3 + local5);
          local8 = Number(local7 >> 16 & 0xFF);
          local9 = Number(local7 >> 8 & 0xFF);
          local10 = Number(local7 & 0xFF);
          this.YDU[local4] = 0.299 * local8 + 0.587 * local9 + 0.114 * local10 - 128;
          this.UDU[local4] = -0.16874 * local8 + -0.33126 * local9 + 0.5 * local10;
          this.VDU[local4] = 0.5 * local8 + -0.41869 * local9 + -0.08131 * local10;
          local4++;
          local6++;
        }
        local5++;
      }
    }

    public function startEncode(param1:BitmapData) : void {
      this.image = param1;
      this.byteout = new ByteArray();
      this.bytenew = 0;
      this.bytepos = 7;
      this.writeWord(65496);
      this.writeAPP0();
      this.writeDQT();
      this.writeSOF0(param1.width,param1.height);
      this.writeDHT();
      this.writeSOS();
      this.bytenew = 0;
      this.bytepos = 7;
    }

    public function encode() : Boolean {
      var local1:int = 0;
      while(local1 < 32) {
        if(this._encode()) {
          return true;
        }
        local1++;
      }
      return false;
    }

    private function _encode() : Boolean {
      this.RGB2YUV(this.image,this.xpos,this.ypos);
      this.DCY = this.processDU(this.YDU,this.fdtbl_Y,this.DCY,this.YDC_HT,this.YAC_HT);
      this.DCU = this.processDU(this.UDU,this.fdtbl_UV,this.DCU,this.UVDC_HT,this.UVAC_HT);
      this.DCV = this.processDU(this.VDU,this.fdtbl_UV,this.DCV,this.UVDC_HT,this.UVAC_HT);
      this.xpos += 8;
      if(this.xpos >= this.image.width) {
        this.xpos = 0;
        this.ypos += 8;
      }
      return this.ypos >= this.image.height;
    }

    public function finishEncode() : ByteArray {
      var local1:BitString = null;
      if(this.bytepos >= 0) {
        local1 = new BitString();
        local1.len = this.bytepos + 1;
        local1.val = (1 << this.bytepos + 1) - 1;
        this.writeBits(local1);
      }
      this.writeWord(65497);
      return this.byteout;
    }
  }
}
