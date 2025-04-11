package _codec.projects.tanks.client.battlefield.models.battle.gui.group {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.models.battle.gui.group.MatchmakingGroupInfoCC;

  public class CodecMatchmakingGroupInfoCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_groupUserIds:ICodec;
    private var codec_hasGroups:ICodec;

    public function CodecMatchmakingGroupInfoCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_groupUserIds = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
      this.codec_hasGroups = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MatchmakingGroupInfoCC = new MatchmakingGroupInfoCC();
      local2.groupUserIds = this.codec_groupUserIds.decode(param1) as Vector.<Long>;
      local2.hasGroups = this.codec_hasGroups.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MatchmakingGroupInfoCC = MatchmakingGroupInfoCC(param2);
      this.codec_groupUserIds.encode(param1,local3.groupUserIds);
      this.codec_hasGroups.encode(param1,local3.hasGroups);
    }
  }
}
