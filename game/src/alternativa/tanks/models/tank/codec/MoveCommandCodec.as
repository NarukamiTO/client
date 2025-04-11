package alternativa.tanks.models.tank.codec {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import flash.utils.IDataInput;
  import flash.utils.IDataOutput;
  import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class MoveCommandCodec implements ICodec {
    private static const ANGLE_FACTOR:Number = Math.PI / 4096;
    private static const ANGULAR_VELOCITY_FACTOR:Number = 0.005;
    private static const CONTROL_MASK:int = 31;
    private static const POSITION_COMPONENT_BITSIZE:int = 17;
    private static const ORIENTATION_COMPONENT_BITSIZE:int = 13;
    private static const LINEAR_VELOCITY_COMPONENT_BITSIZE:int = 13;
    private static const ANGULAR_VELOCITY_COMPONENT_BITSIZE:int = 13;
    private static const BIT_AREA_SIZE:int = 21;

    public function MoveCommandCodec() {
      super();
    }

    [Obfuscation(rename="false")]
    public function init(param1:IProtocol) : void {
    }

    [Obfuscation(rename="false")]
    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      var local3:MoveCommand = MoveCommand(param2);
      var local4:int = local3.control & CONTROL_MASK;
      var local5:int = (local3.turnSpeedNumber & 7) << 5;
      param1.writer.writeByte(local4 | local5);
      var local6:BitArea = new BitArea([],BIT_AREA_SIZE);
      this.writeVector3d(local6,local3.position,POSITION_COMPONENT_BITSIZE,1);
      this.writeVector3d(local6,local3.orientation,ORIENTATION_COMPONENT_BITSIZE,ANGLE_FACTOR);
      this.writeVector3d(local6,local3.linearVelocity,LINEAR_VELOCITY_COMPONENT_BITSIZE,1);
      this.writeVector3d(local6,local3.angularVelocity,ANGULAR_VELOCITY_COMPONENT_BITSIZE,ANGULAR_VELOCITY_FACTOR);
      this.writeArray(param1.writer,local6.getData(),BIT_AREA_SIZE);
    }

    private function writeArray(param1:IDataOutput, param2:Array, param3:int) : void {
      var local4:int = 0;
      while(local4 < param3) {
        param1.writeByte(param2[local4]);
        local4++;
      }
    }

    [Obfuscation(rename="false")]
    public function decode(param1:ProtocolBuffer) : Object {
      var local2:int = int(param1.reader.readByte());
      var local3:int = local2 & CONTROL_MASK;
      var local4:int = local2 >> 5 & 7;
      var local5:BitArea = new BitArea(this.bytesToArray(param1.reader,BIT_AREA_SIZE),BIT_AREA_SIZE);
      var local6:Vector3d = this.readVector3d(local5,POSITION_COMPONENT_BITSIZE,1);
      var local7:Vector3d = this.readVector3d(local5,ORIENTATION_COMPONENT_BITSIZE,ANGLE_FACTOR);
      var local8:Vector3d = this.readVector3d(local5,LINEAR_VELOCITY_COMPONENT_BITSIZE,1);
      var local9:Vector3d = this.readVector3d(local5,ANGULAR_VELOCITY_COMPONENT_BITSIZE,ANGULAR_VELOCITY_FACTOR);
      return new MoveCommand(local9,local3,local8,local7,local6,local4);
    }

    private function bytesToArray(param1:IDataInput, param2:int) : Array {
      var local3:Array = [];
      var local4:int = 0;
      while(local4 < param2) {
        local3[local4] = param1.readByte();
        local4++;
      }
      return local3;
    }

    private function readVector3d(param1:BitArea, param2:int, param3:Number) : Vector3d {
      var local4:Number = (param1.read(param2) - (1 << param2 - 1)) * param3;
      var local5:Number = (param1.read(param2) - (1 << param2 - 1)) * param3;
      var local6:Number = (param1.read(param2) - (1 << param2 - 1)) * param3;
      return new Vector3d(local4,local5,local6);
    }

    private function writeVector3d(param1:BitArea, param2:Vector3d, param3:int, param4:Number) : void {
      var local5:int = 1 << param3 - 1;
      param1.write(param3,this.prepareValue(param2.x,local5,param4));
      param1.write(param3,this.prepareValue(param2.y,local5,param4));
      param1.write(param3,this.prepareValue(param2.z,local5,param4));
    }

    private function prepareValue(param1:Number, param2:int, param3:Number) : int {
      var local4:int = int(param1 / param3);
      var local5:int = local4 < -param2 ? 0 : local4 - param2;
      return int(Math.min(param2,local5));
    }
  }
}
