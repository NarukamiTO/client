package alternativa.engine3d.loaders.collada {
  use namespace collada;

  public class DaeSource extends DaeElement {
    private const FLOAT_ARRAY:String = "float_array";
    private const INT_ARRAY:String = "int_array";
    private const NAME_ARRAY:String = "Name_array";

    public var numbers:Vector.<Number>;
    public var ints:Vector.<int>;
    public var names:Vector.<String>;
    public var stride:int;

    public function DaeSource(param1:XML, param2:DaeDocument) {
      super(param1,param2);
      this.constructArrays();
    }

    private function constructArrays() : void {
      var local4:XML = null;
      var local5:DaeArray = null;
      var local1:XMLList = data.children();
      var local2:int = 0;
      var local3:int = int(local1.length());
      while(local2 < local3) {
        local4 = local1[local2];
        switch(local4.localName()) {
          case this.FLOAT_ARRAY:
          case this.INT_ARRAY:
          case this.NAME_ARRAY:
            local5 = new DaeArray(local4,document);
            if(local5.id != null) {
              document.arrays[local5.id] = local5;
            }
            break;
        }
        local2++;
      }
    }

    private function get accessor() : XML {
      return data.technique_common.accessor[0];
    }

    override protected function parseImplementation() : Boolean {
      var local2:XML = null;
      var local3:DaeArray = null;
      var local4:String = null;
      var local5:int = 0;
      var local6:XML = null;
      var local7:XML = null;
      var local8:int = 0;
      var local9:int = 0;
      var local1:XML = this.accessor;
      if(local1 != null) {
        local2 = local1.@source[0];
        local3 = local2 == null ? null : document.findArray(local2);
        if(local3 != null) {
          local4 = local1.@count[0];
          if(local4 != null) {
            local5 = parseInt(local4.toString(),10);
            local6 = local1.@offset[0];
            local7 = local1.@stride[0];
            local8 = local6 == null ? 0 : int(parseInt(local6.toString(),10));
            local9 = local7 == null ? 1 : int(parseInt(local7.toString(),10));
            local3.parse();
            if(local3.array.length < local8 + local5 * local9) {
              document.logger.logNotEnoughDataError(local1);
              return false;
            }
            this.stride = this.parseArray(local8,local5,local9,local3.array,local3.type);
            return true;
          }
        } else {
          document.logger.logNotFoundError(local2);
        }
      }
      return false;
    }

    private function numValidParams(param1:XMLList) : int {
      var local2:int = 0;
      var local3:int = 0;
      var local4:int = int(param1.length());
      while(local3 < local4) {
        if(param1[local3].@name[0] != null) {
          local2++;
        }
        local3++;
      }
      return local2;
    }

    private function parseArray(param1:int, param2:int, param3:int, param4:Array, param5:String) : int {
      var local10:XML = null;
      var local11:int = 0;
      var local12:String = null;
      var local6:XMLList = this.accessor.param;
      var local7:int = Math.max(this.numValidParams(local6),param3);
      switch(param5) {
        case this.FLOAT_ARRAY:
          this.numbers = new Vector.<Number>(int(local7 * param2));
          break;
        case this.INT_ARRAY:
          this.ints = new Vector.<int>(int(local7 * param2));
          break;
        case this.NAME_ARRAY:
          this.names = new Vector.<String>(int(local7 * param2));
      }
      var local8:int = 0;
      var local9:int = 0;
      while(local9 < local7) {
        local10 = local6[local9];
        if(local10 == null || Boolean(local10.hasOwnProperty("@name"))) {
          switch(param5) {
            case this.FLOAT_ARRAY:
              local11 = 0;
              while(local11 < param2) {
                local12 = param4[int(param1 + param3 * local11 + local9)];
                if(local12.indexOf(",") != -1) {
                  local12 = local12.replace(/,/,".");
                }
                this.numbers[int(local7 * local11 + local8)] = parseFloat(local12);
                local11++;
              }
              break;
            case this.INT_ARRAY:
              local11 = 0;
              while(local11 < param2) {
                this.ints[int(local7 * local11 + local8)] = parseInt(param4[int(param1 + param3 * local11 + local9)],10);
                local11++;
              }
              break;
            case this.NAME_ARRAY:
              local11 = 0;
              while(local11 < param2) {
                this.names[int(local7 * local11 + local8)] = param4[int(param1 + param3 * local11 + local9)];
                local11++;
              }
          }
          local8++;
        }
        local9++;
      }
      return local7;
    }
  }
}
