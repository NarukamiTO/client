package _codec.projects.tanks.client.battlefield.types {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.battlefield.types.DamageType;

  public class CodecDamageType implements ICodec {
    public function CodecDamageType() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DamageType = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = DamageType.SMOKY;
          break;
        case 1:
          local2 = DamageType.SMOKY_CRITICAL;
          break;
        case 2:
          local2 = DamageType.FIREBIRD;
          break;
        case 3:
          local2 = DamageType.FIREBIRD_OVERHEAT;
          break;
        case 4:
          local2 = DamageType.TWINS;
          break;
        case 5:
          local2 = DamageType.RAILGUN;
          break;
        case 6:
          local2 = DamageType.ISIS;
          break;
        case 7:
          local2 = DamageType.MINE;
          break;
        case 8:
          local2 = DamageType.THUNDER;
          break;
        case 9:
          local2 = DamageType.RICOCHET;
          break;
        case 10:
          local2 = DamageType.FREEZE;
          break;
        case 11:
          local2 = DamageType.SHAFT;
          break;
        case 12:
          local2 = DamageType.MACHINE_GUN;
          break;
        case 13:
          local2 = DamageType.SHOTGUN;
          break;
        case 14:
          local2 = DamageType.ROCKET;
          break;
        case 15:
          local2 = DamageType.ARTILLERY;
          break;
        case 16:
          local2 = DamageType.TERMINATOR;
          break;
        case 17:
          local2 = DamageType.BOMB;
          break;
        case 18:
          local2 = DamageType.AT_FIELD;
          break;
        case 19:
          local2 = DamageType.NUCLEAR;
          break;
        case 20:
          local2 = DamageType.GAUSS;
      }
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:int = int(param2.value);
      param1.writer.writeInt(local3);
    }
  }
}
