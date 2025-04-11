package alternativa.utils.filters {
  public class DynamicMatrix {
    public static const MATRIX_ORDER_PREPEND:int = 0;
    public static const MATRIX_ORDER_APPEND:int = 1;

    protected var m_width:int;
    protected var m_height:int;
    protected var m_matrix:Array;

    public function DynamicMatrix(param1:int, param2:int) {
      super();
      this.Create(param1,param2);
    }

    protected function Create(param1:int, param2:int) : void {
      var local3:int = 0;
      var local4:int = 0;
      if(param1 > 0 && param2 > 0) {
        this.m_width = param1;
        this.m_height = param2;
        this.m_matrix = new Array(param2);
        local3 = 0;
        while(local3 < param2) {
          this.m_matrix[local3] = new Array(param1);
          local4 = 0;
          while(local4 < param2) {
            this.m_matrix[local3][local4] = 0;
            local4++;
          }
          local3++;
        }
      }
    }

    protected function Destroy() : void {
      this.m_matrix = null;
    }

    public function GetWidth() : Number {
      return this.m_width;
    }

    public function GetHeight() : Number {
      return this.m_height;
    }

    public function GetValue(param1:int, param2:int) : Number {
      var local3:Number = 0;
      if(param1 >= 0 && param1 < this.m_height && param2 >= 0 && param2 <= this.m_width) {
        local3 = Number(this.m_matrix[param1][param2]);
      }
      return local3;
    }

    public function SetValue(param1:int, param2:int, param3:Number) : void {
      if(param1 >= 0 && param1 < this.m_height && param2 >= 0 && param2 <= this.m_width) {
        this.m_matrix[param1][param2] = param3;
      }
    }

    public function LoadIdentity() : void {
      var local1:int = 0;
      var local2:int = 0;
      if(Boolean(this.m_matrix)) {
        local1 = 0;
        while(local1 < this.m_height) {
          local2 = 0;
          while(local2 < this.m_width) {
            if(local1 == local2) {
              this.m_matrix[local1][local2] = 1;
            } else {
              this.m_matrix[local1][local2] = 0;
            }
            local2++;
          }
          local1++;
        }
      }
    }

    public function LoadZeros() : void {
      var local1:int = 0;
      var local2:int = 0;
      if(Boolean(this.m_matrix)) {
        local1 = 0;
        while(local1 < this.m_height) {
          local2 = 0;
          while(local2 < this.m_width) {
            this.m_matrix[local1][local2] = 0;
            local2++;
          }
          local1++;
        }
      }
    }

    public function Multiply(param1:DynamicMatrix, param2:int = 0) : Boolean {
      var local5:DynamicMatrix = null;
      var local6:int = 0;
      var local7:int = 0;
      var local8:Number = NaN;
      var local9:int = 0;
      var local10:int = 0;
      if(!this.m_matrix || !param1) {
        return false;
      }
      var local3:int = param1.GetHeight();
      var local4:int = param1.GetWidth();
      if(param2 == MATRIX_ORDER_APPEND) {
        if(this.m_width != local3) {
          return false;
        }
        local5 = new DynamicMatrix(local4,this.m_height);
        local6 = 0;
        while(local6 < this.m_height) {
          local7 = 0;
          while(local7 < local4) {
            local8 = 0;
            local9 = 0;
            local10 = 0;
            while(local9 < Math.max(this.m_height,local3) && local10 < Math.max(this.m_width,local4)) {
              local8 += param1.GetValue(local9,local7) * this.m_matrix[local6][local10];
              local9++;
              local10++;
            }
            local5.SetValue(local6,local7,local8);
            local7++;
          }
          local6++;
        }
        this.Destroy();
        this.Create(local4,this.m_height);
        local6 = 0;
        while(local6 < local3) {
          local7 = 0;
          while(local7 < this.m_width) {
            this.m_matrix[local6][local7] = local5.GetValue(local6,local7);
            local7++;
          }
          local6++;
        }
      } else {
        if(this.m_height != local4) {
          return false;
        }
        local5 = new DynamicMatrix(this.m_width,local3);
        local6 = 0;
        while(local6 < local3) {
          local7 = 0;
          while(local7 < this.m_width) {
            local8 = 0;
            local9 = 0;
            local10 = 0;
            while(local9 < Math.max(local3,this.m_height) && local10 < Math.max(local4,this.m_width)) {
              local8 += this.m_matrix[local9][local7] * param1.GetValue(local6,local10);
              local9++;
              local10++;
            }
            local5.SetValue(local6,local7,local8);
            local7++;
          }
          local6++;
        }
        this.Destroy();
        this.Create(this.m_width,local3);
        local6 = 0;
        while(local6 < local3) {
          local7 = 0;
          while(local7 < this.m_width) {
            this.m_matrix[local6][local7] = local5.GetValue(local6,local7);
            local7++;
          }
          local6++;
        }
      }
      return true;
    }

    public function MultiplyNumber(param1:Number) : Boolean {
      var local3:int = 0;
      var local4:Number = NaN;
      if(!this.m_matrix) {
        return false;
      }
      var local2:int = 0;
      while(local2 < this.m_height) {
        local3 = 0;
        while(local3 < this.m_width) {
          local4 = 0;
          local4 = this.m_matrix[local2][local3] * param1;
          this.m_matrix[local2][local3] = local4;
          local3++;
        }
        local2++;
      }
      return true;
    }

    public function Add(param1:DynamicMatrix) : Boolean {
      var local5:int = 0;
      var local6:Number = NaN;
      if(!this.m_matrix || !param1) {
        return false;
      }
      var local2:int = param1.GetHeight();
      var local3:int = param1.GetWidth();
      if(this.m_width != local3 || this.m_height != local2) {
        return false;
      }
      var local4:int = 0;
      while(local4 < this.m_height) {
        local5 = 0;
        while(local5 < this.m_width) {
          local6 = 0;
          local6 = this.m_matrix[local4][local5] + param1.GetValue(local4,local5);
          this.m_matrix[local4][local5] = local6;
          local5++;
        }
        local4++;
      }
      return true;
    }
  }
}
