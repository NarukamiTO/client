package _codec.projects.tanks.client.clans.clan.permissions {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.client.clans.clan.permissions.ClanPermissionsCC;

  public class CodecClanPermissionsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_actions:ICodec;

    public function CodecClanPermissionsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_actions = param1.getCodec(new CollectionCodecInfo(new EnumCodecInfo(ClanAction,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClanPermissionsCC = new ClanPermissionsCC();
      local2.actions = this.codec_actions.decode(param1) as Vector.<ClanAction>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ClanPermissionsCC = ClanPermissionsCC(param2);
      this.codec_actions.encode(param1,local3.actions);
    }
  }
}
