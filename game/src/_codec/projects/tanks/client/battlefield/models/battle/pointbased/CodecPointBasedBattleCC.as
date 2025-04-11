package _codec.projects.tanks.client.battlefield.models.battle.pointbased {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
  import projects.tanks.client.battlefield.models.battle.pointbased.PointBasedBattleCC;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;

  public class CodecPointBasedBattleCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_flags:ICodec;
    private var codec_teamPoints:ICodec;

    public function CodecPointBasedBattleCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_flags = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ClientFlag,false),false,1));
      this.codec_teamPoints = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ClientTeamPoint,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PointBasedBattleCC = new PointBasedBattleCC();
      local2.flags = this.codec_flags.decode(param1) as Vector.<ClientFlag>;
      local2.teamPoints = this.codec_teamPoints.decode(param1) as Vector.<ClientTeamPoint>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PointBasedBattleCC = PointBasedBattleCC(param2);
      this.codec_flags.encode(param1,local3.flags);
      this.codec_teamPoints.encode(param1,local3.teamPoints);
    }
  }
}
