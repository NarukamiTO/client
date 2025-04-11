package alternativa.utils.filters {
  public class ColorMatrix extends DynamicMatrix {
    protected static const LUMINANCER:Number = 0.3086;
    protected static const LUMINANCEG:Number = 0.6094;
    protected static const LUMINANCEB:Number = 0.082;

    public function ColorMatrix() {
      super(5,5);
      LoadIdentity();
    }

    public function SetBrightnessMatrix(param1:Number) : void {
      if(!m_matrix) {
        return;
      }
      m_matrix[0][4] = param1;
      m_matrix[1][4] = param1;
      m_matrix[2][4] = param1;
    }

    public function SetContrastMatrix(param1:Number) : void {
      if(!m_matrix) {
        return;
      }
      var local2:Number = 0.5 * (127 - param1);
      param1 /= 127;
      m_matrix[0][0] = param1;
      m_matrix[1][1] = param1;
      m_matrix[2][2] = param1;
      m_matrix[0][4] = local2;
      m_matrix[1][4] = local2;
      m_matrix[2][4] = local2;
    }

    public function SetSaturationMatrix(param1:Number) : void {
      if(!m_matrix) {
        return;
      }
      var local2:Number = 1 - param1;
      var local3:Number = local2 * LUMINANCER;
      m_matrix[0][0] = local3 + param1;
      m_matrix[1][0] = local3;
      m_matrix[2][0] = local3;
      local3 = local2 * LUMINANCEG;
      m_matrix[0][1] = local3;
      m_matrix[1][1] = local3 + param1;
      m_matrix[2][1] = local3;
      local3 = local2 * LUMINANCEB;
      m_matrix[0][2] = local3;
      m_matrix[1][2] = local3;
      m_matrix[2][2] = local3 + param1;
    }

    public function SetHueMatrix(param1:Number) : void {
      var local11:int = 0;
      if(!m_matrix) {
        return;
      }
      LoadIdentity();
      var local2:DynamicMatrix = new DynamicMatrix(3,3);
      var local3:DynamicMatrix = new DynamicMatrix(3,3);
      var local4:DynamicMatrix = new DynamicMatrix(3,3);
      var local5:Number = Math.cos(param1);
      var local6:Number = Math.sin(param1);
      var local7:Number = 0.213;
      var local8:Number = 0.715;
      var local9:Number = 0.072;
      local2.SetValue(0,0,local7);
      local2.SetValue(1,0,local7);
      local2.SetValue(2,0,local7);
      local2.SetValue(0,1,local8);
      local2.SetValue(1,1,local8);
      local2.SetValue(2,1,local8);
      local2.SetValue(0,2,local9);
      local2.SetValue(1,2,local9);
      local2.SetValue(2,2,local9);
      local3.SetValue(0,0,1 - local7);
      local3.SetValue(1,0,-local7);
      local3.SetValue(2,0,-local7);
      local3.SetValue(0,1,-local8);
      local3.SetValue(1,1,1 - local8);
      local3.SetValue(2,1,-local8);
      local3.SetValue(0,2,-local9);
      local3.SetValue(1,2,-local9);
      local3.SetValue(2,2,1 - local9);
      local3.MultiplyNumber(local5);
      local4.SetValue(0,0,-local7);
      local4.SetValue(1,0,0.143);
      local4.SetValue(2,0,-(1 - local7));
      local4.SetValue(0,1,-local8);
      local4.SetValue(1,1,0.14);
      local4.SetValue(2,1,local8);
      local4.SetValue(0,2,1 - local9);
      local4.SetValue(1,2,-0.283);
      local4.SetValue(2,2,local9);
      local4.MultiplyNumber(local6);
      local2.Add(local3);
      local2.Add(local4);
      var local10:int = 0;
      while(local10 < 3) {
        local11 = 0;
        while(local11 < 3) {
          m_matrix[local10][local11] = local2.GetValue(local10,local11);
          local11++;
        }
        local10++;
      }
    }

    public function GetFlatArray() : Array {
      var local4:int = 0;
      if(!m_matrix) {
        return null;
      }
      var local1:Array = new Array();
      var local2:int = 0;
      var local3:int = 0;
      while(local3 < 4) {
        local4 = 0;
        while(local4 < 5) {
          local1[local2] = m_matrix[local3][local4];
          local2++;
          local4++;
        }
        local3++;
      }
      return local1;
    }
  }
}

class XFormData {
  public var ox:Number;
  public var oy:Number;
  public var oz:Number;

  public function XFormData() {
    super();
  }
}
