package _codec.projects.tanks.client.clans.clan.permissions {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.clans.clan.permissions.ClanPermission;

  public class CodecClanPermission implements ICodec {
    public function CodecClanPermission() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClanPermission = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = ClanPermission.SUPREME_COMMANDER;
          break;
        case 1:
          local2 = ClanPermission.COMMANDER;
          break;
        case 2:
          local2 = ClanPermission.OFFICER;
          break;
        case 3:
          local2 = ClanPermission.SERGEANT;
          break;
        case 4:
          local2 = ClanPermission.VETERAN;
          break;
        case 5:
          local2 = ClanPermission.PRIVATE;
          break;
        case 6:
          local2 = ClanPermission.NOVICE;
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
