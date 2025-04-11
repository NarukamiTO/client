package alternativa.engine3d.animation {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.animation.keys.TransformKey;
  import alternativa.engine3d.core.Object3D;
  import flash.geom.Vector3D;

  use namespace alternativa3d;

  public class AnimationState {
    public var useCount:int = 0;
    public var transform:TransformKey = new TransformKey();
    public var transformWeightSum:Number = 0;
    public var numbers:Object = new Object();
    public var numberWeightSums:Object = new Object();

    public function AnimationState() {
      super();
    }

    public function reset() : void {
      var local1:String = null;
      this.transformWeightSum = 0;
      for(local1 in this.numbers) {
        delete this.numbers[local1];
        delete this.numberWeightSums[local1];
      }
    }

    public function addWeightedTransform(param1:TransformKey, param2:Number) : void {
      this.transformWeightSum += param2;
      this.transform.interpolate(this.transform,param1,param2 / this.transformWeightSum);
    }

    public function addWeightedNumber(param1:String, param2:Number, param3:Number) : void {
      var local5:Number = NaN;
      var local4:Number = Number(this.numberWeightSums[param1]);
      if(local4 == local4) {
        local4 += param3;
        param3 /= local4;
        local5 = Number(this.numbers[param1]);
        this.numbers[param1] = (1 - param3) * local5 + param3 * param2;
        this.numberWeightSums[param1] = local4;
      } else {
        this.numbers[param1] = param2;
        this.numberWeightSums[param1] = param3;
      }
    }

    public function apply(param1:Object3D) : void {
      var local2:Number = NaN;
      var local3:Number = NaN;
      var local4:String = null;
      if(this.transformWeightSum > 0) {
        param1.x = this.transform.alternativa3d::x;
        param1.y = this.transform.alternativa3d::y;
        param1.z = this.transform.alternativa3d::z;
        this.setEulerAngles(this.transform.alternativa3d::rotation,param1);
        param1.scaleX = this.transform.alternativa3d::scaleX;
        param1.scaleY = this.transform.alternativa3d::scaleY;
        param1.scaleZ = this.transform.alternativa3d::scaleZ;
      }
      for(local4 in this.numbers) {
        switch(local4) {
          case "x":
            local2 = Number(this.numberWeightSums["x"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.x = (1 - local3) * param1.x + local3 * this.numbers["x"];
            break;
          case "y":
            local2 = Number(this.numberWeightSums["y"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.y = (1 - local3) * param1.y + local3 * this.numbers["y"];
            break;
          case "z":
            local2 = Number(this.numberWeightSums["z"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.z = (1 - local3) * param1.z + local3 * this.numbers["z"];
            break;
          case "rotationX":
            local2 = Number(this.numberWeightSums["rotationX"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.rotationX = (1 - local3) * param1.rotationX + local3 * this.numbers["rotationX"];
            break;
          case "rotationY":
            local2 = Number(this.numberWeightSums["rotationY"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.rotationY = (1 - local3) * param1.rotationY + local3 * this.numbers["rotationY"];
            break;
          case "rotationZ":
            local2 = Number(this.numberWeightSums["rotationZ"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.rotationZ = (1 - local3) * param1.rotationZ + local3 * this.numbers["rotationZ"];
            break;
          case "scaleX":
            local2 = Number(this.numberWeightSums["scaleX"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.scaleX = (1 - local3) * param1.scaleX + local3 * this.numbers["scaleX"];
            break;
          case "scaleY":
            local2 = Number(this.numberWeightSums["scaleY"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.scaleY = (1 - local3) * param1.scaleY + local3 * this.numbers["scaleY"];
            break;
          case "scaleZ":
            local2 = Number(this.numberWeightSums["scaleZ"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.scaleZ = (1 - local3) * param1.scaleZ + local3 * this.numbers["scaleZ"];
            break;
          default:
            param1[local4] = this.numbers[local4];
            break;
        }
      }
    }

    public function applyObject(param1:Object) : void {
      var local2:Number = NaN;
      var local3:Number = NaN;
      var local4:String = null;
      if(this.transformWeightSum > 0) {
        param1.x = this.transform.alternativa3d::x;
        param1.y = this.transform.alternativa3d::y;
        param1.z = this.transform.alternativa3d::z;
        this.setEulerAnglesObject(this.transform.alternativa3d::rotation,param1);
        param1.scaleX = this.transform.alternativa3d::scaleX;
        param1.scaleY = this.transform.alternativa3d::scaleY;
        param1.scaleZ = this.transform.alternativa3d::scaleZ;
      }
      for(local4 in this.numbers) {
        switch(local4) {
          case "x":
            local2 = Number(this.numberWeightSums["x"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.x = (1 - local3) * param1.x + local3 * this.numbers["x"];
            break;
          case "y":
            local2 = Number(this.numberWeightSums["y"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.y = (1 - local3) * param1.y + local3 * this.numbers["y"];
            break;
          case "z":
            local2 = Number(this.numberWeightSums["z"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.z = (1 - local3) * param1.z + local3 * this.numbers["z"];
            break;
          case "rotationX":
            local2 = Number(this.numberWeightSums["rotationX"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.rotationX = (1 - local3) * param1.rotationX + local3 * this.numbers["rotationX"];
            break;
          case "rotationY":
            local2 = Number(this.numberWeightSums["rotationY"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.rotationY = (1 - local3) * param1.rotationY + local3 * this.numbers["rotationY"];
            break;
          case "rotationZ":
            local2 = Number(this.numberWeightSums["rotationZ"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.rotationZ = (1 - local3) * param1.rotationZ + local3 * this.numbers["rotationZ"];
            break;
          case "scaleX":
            local2 = Number(this.numberWeightSums["scaleX"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.scaleX = (1 - local3) * param1.scaleX + local3 * this.numbers["scaleX"];
            break;
          case "scaleY":
            local2 = Number(this.numberWeightSums["scaleY"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.scaleY = (1 - local3) * param1.scaleY + local3 * this.numbers["scaleY"];
            break;
          case "scaleZ":
            local2 = Number(this.numberWeightSums["scaleZ"]);
            local3 = local2 / (local2 + this.transformWeightSum);
            param1.scaleZ = (1 - local3) * param1.scaleZ + local3 * this.numbers["scaleZ"];
            break;
          default:
            param1[local4] = this.numbers[local4];
            break;
        }
      }
    }

    private function setEulerAngles(param1:Vector3D, param2:Object3D) : void {
      var local3:Number = 2 * param1.x * param1.x;
      var local4:Number = 2 * param1.y * param1.y;
      var local5:Number = 2 * param1.z * param1.z;
      var local6:Number = 2 * param1.x * param1.y;
      var local7:Number = 2 * param1.y * param1.z;
      var local8:Number = 2 * param1.z * param1.x;
      var local9:Number = 2 * param1.w * param1.x;
      var local10:Number = 2 * param1.w * param1.y;
      var local11:Number = 2 * param1.w * param1.z;
      var local12:Number = 1 - local4 - local5;
      var local13:Number = local6 - local11;
      var local14:Number = local6 + local11;
      var local15:Number = 1 - local3 - local5;
      var local16:Number = local8 - local10;
      var local17:Number = local7 + local9;
      var local18:Number = 1 - local3 - local4;
      if(-1 < local16 && local16 < 1) {
        param2.rotationX = Math.atan2(local17,local18);
        param2.rotationY = -Math.asin(local16);
        param2.rotationZ = Math.atan2(local14,local12);
      } else {
        param2.rotationX = 0;
        param2.rotationY = local16 <= -1 ? Math.PI : -Math.PI;
        param2.rotationY *= 0.5;
        param2.rotationZ = Math.atan2(-local13,local15);
      }
    }

    private function setEulerAnglesObject(param1:Vector3D, param2:Object) : void {
      var local3:Number = 2 * param1.x * param1.x;
      var local4:Number = 2 * param1.y * param1.y;
      var local5:Number = 2 * param1.z * param1.z;
      var local6:Number = 2 * param1.x * param1.y;
      var local7:Number = 2 * param1.y * param1.z;
      var local8:Number = 2 * param1.z * param1.x;
      var local9:Number = 2 * param1.w * param1.x;
      var local10:Number = 2 * param1.w * param1.y;
      var local11:Number = 2 * param1.w * param1.z;
      var local12:Number = 1 - local4 - local5;
      var local13:Number = local6 - local11;
      var local14:Number = local6 + local11;
      var local15:Number = 1 - local3 - local5;
      var local16:Number = local8 - local10;
      var local17:Number = local7 + local9;
      var local18:Number = 1 - local3 - local4;
      if(-1 < local16 && local16 < 1) {
        param2.rotationX = Math.atan2(local17,local18);
        param2.rotationY = -Math.asin(local16);
        param2.rotationZ = Math.atan2(local14,local12);
      } else {
        param2.rotationX = 0;
        param2.rotationY = local16 <= -1 ? Math.PI : -Math.PI;
        param2.rotationY *= 0.5;
        param2.rotationZ = Math.atan2(-local13,local15);
      }
    }
  }
}
