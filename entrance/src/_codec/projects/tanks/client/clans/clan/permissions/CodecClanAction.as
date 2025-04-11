package _codec.projects.tanks.client.clans.clan.permissions {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.clans.clan.permissions.ClanAction;

  public class CodecClanAction implements ICodec {
    public function CodecClanAction() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClanAction = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = ClanAction.DELETE_CLAN;
          break;
        case 1:
          local2 = ClanAction.PERMISSION_DISTRIBUTION;
          break;
        case 2:
          local2 = ClanAction.REMOVE_FROM_CLAN;
          break;
        case 3:
          local2 = ClanAction.ADDING_TO_CLAN;
          break;
        case 4:
          local2 = ClanAction.ACCESS_BLOCK;
          break;
        case 5:
          local2 = ClanAction.BATTLE_GROUPS;
          break;
        case 6:
          local2 = ClanAction.INVITE_TO_CLAN;
          break;
        case 7:
          local2 = ClanAction.EDIT_PROFILE;
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
